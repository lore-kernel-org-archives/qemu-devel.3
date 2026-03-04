Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61144EF9008
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 16:55:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxpVk-0005fX-S4; Wed, 04 Mar 2026 11:55:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vxpVj-0005fC-O1
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:55:47 -0500
Received: from mail-dy1-x1342.google.com ([2607:f8b0:4864:20::1342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1vxpVi-0003o1-3f
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:55:47 -0500
Received: by mail-dy1-x1342.google.com with SMTP id
 5a478bee46e88-2ba9c484e5eso6603915eec.1
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 08:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772643345; x=1773248145; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5fi9HW2CT3G0OGmSZ2vDozZ8N8j3QwBVhy3wU+AZtuQ=;
 b=GbhM1iqWCTiWkX+awwdNM5vPCgHB4n8/Gp4O8J6wpRqHpwy/FvCTCNOwTXPOLDHC3y
 +v6UsZ9kyIU4y5rNH87yNYIn+MrTTJQ0T2BP2XEWrSatnIBjOqm5xhJnJVu9+F7rZYTO
 J3lYlD0VlqSS3Ed+5EGepZYowzWmGhJR4Y2lG/jkdiKMjXL3UWYUIJAfwIlTtDnwD2z7
 9Mg0hOMLf3BxZ1nv6UWkmuGgid3SgH3oJLChRXQ9g1Nr7wHaKGyFMXr90lq8uAOuJsFg
 ZCw7O1pr6J1Uwx2ps9+x1VZQPtdfVG08HhFzzq3vNYWLkj+6Y7TfrjfnoP4iQVV3wKox
 NBKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772643345; x=1773248145;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5fi9HW2CT3G0OGmSZ2vDozZ8N8j3QwBVhy3wU+AZtuQ=;
 b=ORxFZ37wPBsVZQEKM1YzdJqZlJJtpojFtMSsh+sdi9OZ4Bah1/HHn2qQKafO7gIqjV
 +kp6dEohjkmSSR3rBIJvFdwqxScTpv+6aa2JxJHcx2fsArkfvCd6OtvBw82s1xZRD+D9
 YiOv4609k7eWpXH3AS/cvuqlkJ5Qr+ISVcaI3Jr1dB4sHc+9EzCXCj9LxfQgVpmF6WZt
 +KEF2nwndtUmukOkbDbcTq+ftDJ1Ssy7/6w8WH6+6TCAf0ug9A0mA2VpeANjvRxlGNrp
 rhaCgRAh+q8P7NSb0SVl0YNNNqE+1f4Ch84HGZcLZpnVqR3PkpplV7TjDdlQC837uZ+M
 6CTg==
X-Gm-Message-State: AOJu0YzxPMKdpCoGPTE0d4rRfGM9MqzfSsdE68YkpM02sGrd4oTEIgjY
 aVEPGUxLZd54+5VTkikP3Cag/2BwGS4uUcnvgNTKRLtt4dcsvhPj7CuJ
X-Gm-Gg: ATEYQzxnzCvoMJOLcKiw4Ab3N/OfPSbpsa4JlK5Xtl73IAnONrD8N1ONjp+aWI6gvKv
 opuiSSK0FyBffOknbdOvONKn5tGRPDEqp3A9mjYit08UzkRBb5iF9ieyq0WL2WcAjjKAVEuwZi8
 4ZEhY70Ro2qOyMGMoJiFoWRFjCOTww6vO6eJaRWQnx8RBq9U6X1FKYDiQD+MTTQzm8nmTXUmb8e
 7Ue8i41ogTn7PWWvh0yM86sCiXHsNNeyuOqib7IXTt2LcpYWCxNmChFDzJ17RGvNZg3IDWrB2ga
 KxAJudCJrZ5Ba3RtFr340Hvf5caQlIkQDj5rjDFDH9dXJnqKpKj803Rp/MBTumlF3Bk8pT3D8cK
 Gus6GBRQiaV9zz4TIzonsp7jXhg7/eq3knUXF0DZTM5iuOpa8vPV7C/2D7xaNheEbxfHUnyX4NT
 Y5ZkKZabXm0fq1TbBkLkpb9F91jz4ajPKVXhfUvhOl4kuAX8IncvHgp+gz6fDzKzw573MxMok0/
 n/5wYQqnpGDfsCeEivqvk60EKe7rUE=
X-Received: by 2002:a05:7300:a14a:b0:2ba:7069:686c with SMTP id
 5a478bee46e88-2be310308f5mr1110410eec.17.1772643344512; 
 Wed, 04 Mar 2026 08:55:44 -0800 (PST)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2bdd1e02f95sm15307836eec.13.2026.03.04.08.55.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 08:55:44 -0800 (PST)
Date: Thu, 5 Mar 2026 00:55:19 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v4 8/9] target/riscv: rvv: Support Zvfbfa vector bf16
 operations
Message-ID: <aahcp3fivs8UbRcw@ZEVORN-PC.localdomain>
References: <20260304132514.2889449-1-max.chou@sifive.com>
 <20260304132514.2889449-9-max.chou@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304132514.2889449-9-max.chou@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1342;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1342.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Mar 04, 2026 at 09:25:12PM +0800, Max Chou wrote:
> According to the Zvfbfa ISA spec v0.1, the following vector floating
> point instructions have different bahaviors depend on the ALTFMT and
"bahaviors" -> "behaviors".

[...]
>  static bool opfvf_trans(uint32_t vd, uint32_t rs1, uint32_t vs2,
> -                        uint32_t data, gen_helper_opfvf *fn, DisasContext *s)
> +                        uint32_t data, gen_helper_opfvf *fn, DisasContext *s,
> +                        bool do_bf16_nanbox)
>  {
>      TCGv_ptr dest, src2, mask;
>      TCGv_i32 desc;
> @@ -2403,7 +2461,7 @@ static bool opfvf_trans(uint32_t vd, uint32_t rs1, uint32_t vs2,
>  
>      /* NaN-box f[rs1] */
>      t1 = tcg_temp_new_i64();
> -    do_nanbox(s, t1, cpu_fpr[rs1]);
> +    do_nanbox(s, t1, cpu_fpr[rs1], do_bf16_nanbox);
this is a bug.

All arithmetic OPFVF BFA instructions pass
`do_bf16_nanbox=false`, but they should pass `true`.

When altfmt=1 and a scalar f-register operand is
improperly NaN-boxed, the code substitutes FP16
canonical NaN (0x7e00). But 0x7e00 interpreted as
BF16 is a normal finite number (~2^125), NOT NaN.
This produces incorrect arithmetic results.

static void do_nanbox(DisasContext *s, TCGv_i64 out, TCGv_i64 in,
                      bool do_bf16_nanbox)
{
    if (s->sew == MO_16) {
        if (s->altfmt && do_bf16_nanbox) {  /* real: s->altfmt && false */
            gen_check_nanbox_h_bf16(out, in); /* NaN: 0x7fc0 */
        } else {
            gen_check_nanbox_h(out, in);      /* NaN: 0x7e00 */
        }
    }
    [...]
}

Affected callers:

> GEN_OPFVF_BFA_TRANS(vfadd_vf, ..., false)
> GEN_OPFVF_BFA_TRANS(vfsub_vf, ..., false)
> GEN_OPFVF_BFA_TRANS(vfrsub_vf, ..., false)
> GEN_OPFVF_BFA_TRANS(vfmul_vf, ..., false)
> GEN_OPFVF_BFA_TRANS(vfmacc_vf, ..., false)
> GEN_OPFVF_BFA_TRANS(vfnmacc_vf, ..., false)
> GEN_OPFVF_BFA_TRANS(vfmsac_vf, ..., false)
> GEN_OPFVF_BFA_TRANS(vfnmsac_vf, ..., false)
> GEN_OPFVF_BFA_TRANS(vfmadd_vf, ..., false)
> GEN_OPFVF_BFA_TRANS(vfnmadd_vf, ..., false)
> GEN_OPFVF_BFA_TRANS(vfmsub_vf, ..., false)
> GEN_OPFVF_BFA_TRANS(vfnmsub_vf, ..., false)
> GEN_OPFVF_BFA_TRANS(vfmin_vf, ..., false)
> GEN_OPFVF_BFA_TRANS(vfmax_vf, ..., false)
> GEN_OPFVF_BFA_TRANS(vmfeq_vf, ..., false)
> GEN_OPFVF_BFA_TRANS(vmfne_vf, ..., false)
> GEN_OPFVF_BFA_TRANS(vmflt_vf, ..., false)
> GEN_OPFVF_BFA_TRANS(vmfle_vf, ..., false)
> GEN_OPFVF_BFA_TRANS(vmfgt_vf, ..., false)
> GEN_OPFVF_BFA_TRANS(vmfge_vf, ..., false)
[...]

All of these should be `true`. The widen macros
(GEN_OPFVF_WIDEN_BFA_TRANS, GEN_OPFWF_WIDEN_BFA_TRANS)
hardcode `false` and should also be `true`.

The sign-injection (vfsgnj/vfsgnjn/vfsgnjx),
vfmerge, vfslide1up/down, vfmv.v.f, and vfmv.s.f
correctly pass `true`. The intent seems clear --
the `false` values are simply a mistake.

I suggest that since all BFA callers are supposed to
pass true, we consider removing the BF16_NANBOX parameter
entirely and having do_nanbox() directly check s->altfmt
(this is what patch 7 originally implemented before
patch 8 added the parameter).

Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

Best regards,
Chao Liu

