Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2DA2C9833F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 12:17:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBAIb-00082a-3d; Mon, 28 Sep 2026 08:17:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBAIE-0007wg-6X
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 08:17:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBAIC-0007IH-EZ
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 08:17:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790597830;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X6MkhYSXdvjqVBYZkFBXxJ4TICCkONu4xBl91uarlvo=;
 b=gfYGTXiMaR4p4ywoTjzoUou4oMX9McM9lOGq239wzTlaNVDbYA5guP4x2xGdKkgYoywsou
 g0TQOO4gucJGgp9qgXwWkBHu476DSw7uRyNHUGXl6IuAzK/v4FFIbnvDuvyuWF4GOlkY1J
 5q2zqgv+6XJpCwv4cc7o3Q06o6/uySA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-RT6of1MfMeiHtWQXVVBt_A-1; Mon, 28 Sep 2026 08:17:09 -0400
X-MC-Unique: RT6of1MfMeiHtWQXVVBt_A-1
X-Mimecast-MFC-AGG-ID: RT6of1MfMeiHtWQXVVBt_A_1790597828
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-47f2de3ba47so2258937f8f.1
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 05:17:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790597828; cv=none;
 d=google.com; s=arc-20260327;
 b=SMph3/yrU359bp1DIQYXSEJVcJDpizSyQa8RoxJ9yQ7Ucgsh5e6cY8eYuRgzgg283C
 h0yPmO6SVukw1Gy6Bj9IYpwr0w0UpBDteoCpTr/yskg5abRI3rDjGJJvyaY/Qt210G4B
 +vB2ftvyPQFs1mXq60lvkeh8mzmgskCH+4R3Qo7qoQGcgpt9oBaMMmdRQ86GCgSIaLlW
 AYvNrtMWaXgaogyq60o1khqOSvj84hVZOUKN5oCS9+pi9KVQybKE5slydUXxDt4sqS7W
 dFtQD7F7EoijjNQEuTiYAzGSElZJxNOh7xIUXmKQnFv2d7JtS7tHWEKC7CppNqIX9/FG
 UuOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=X6MkhYSXdvjqVBYZkFBXxJ4TICCkONu4xBl91uarlvo=;
 fh=P/6kFfmcUQOACeCC3ugxlkT5ChKuCFUgoetN96i5Go4=;
 b=YanF3LK4Ks1Pb0at7ToQl6QRbkTRoE1AdUI5HM+WwvsP3rx9pysCn5gq1Ar3b/0YMS
 vuWo93a9SPeTxtOjK80duaD4xUJxOc+37kaEuPBCypzpRcYysMl+OoCwHrZufTLElEox
 6GC02VQQlRn/OJS2xjTo548UkifKXW2pc3qd/l7dEl6DMVLTTKnZNXgyLBnvPZukAKrd
 T0Mh/m6WBWnKc8oInxgpwiRzCNa81+NbZLXif8jtZSaO6czQjYeqPZE0cT3J0kWxqa6B
 vqqcqbj65F7M6vF3ZUFvxSlMAHBdRsTBhrQA+GW3iORlV00g+fSzh0igupMoSus984QG
 C6vw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790597828; x=1791202628; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=X6MkhYSXdvjqVBYZkFBXxJ4TICCkONu4xBl91uarlvo=;
 b=n+YaM4SMdsNGOXF8FCjt1u1dxiTJ7a8f/pc+s1VyrvYHhHgLPIlNIZPHSLtX+c9Nvk
 VVrEz/oURZhUWQV8TFa1Qes5Sph8tFJLboJu1rlilllqz89oqV+EMU7G/eD0fSgL6I2K
 ukRQWOOI+9b1O/e9o9jw5fRW2gGBH8lqQeeC+6D84fPn68oRRH0Mt7gsYDcyRQaRohAr
 xzuDk4ScLunvqZSblRTQaUeggYZjuCM+9mx6eZhpHXVcYhvUI+VGgU87xqreQYSZb9Xd
 m/nFTt2xO84zLVr0vrIBpm+P7TWP4olvz5x4sCqR2LFwyqTFP25NMQnHqlzmeHzJZTTT
 IddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790597828; x=1791202628;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=X6MkhYSXdvjqVBYZkFBXxJ4TICCkONu4xBl91uarlvo=;
 b=IbRzVAS7EyVWPHiDc4gylqJDrq8NCpW/Vjpx0ks4hyRos3b/HvK44z9RFa6vg9eYs6
 ppn149gut/qhz4wh0AB6Fz7dBzabZWz9eOpV2HiaFurOSPXe0reKuZrz5IcUZZc38fuv
 RKdFM3w/GkVTWYxltSdMfb7qkPgindca3sdw9kTt4VVosuFndeODaxAx4DUQerV9bMPX
 PJoq2ShRqZPB9jCDsHgffXyCLT35pDGiIRojN8j6ThjL9rb9Ecd+a12H9wQ60DJe19kS
 L2L0gfFpJlsmQzWMTfM31j4S81HDaQ6R3NjcKaZTwV0VOrPmQj866FCOEZfrbK7dP+vJ
 3KzQ==
X-Gm-Message-State: AFq9FYK7JZE9OnAEfZcxWVkk/PQ/tHKfDKQiI1dAUxZ9+0prFwBVqvwT
 /ZbzsgYFw2Z3shLubF8dgUYJoSmujky8hMaYZGdZNnGqULePkmDQ2SVN1itONoCV6aULxUMb3hx
 Tse6a5Phz2Fyg7dPCL0GzNX6OzzrEe+juYoHXcVgERijXpLcn3OJ6dvHwn6fY9vMG1wU/suhRg3
 /Op+Fq4nse4ZwX+bMX2emCXIlcHPAlgJY=
X-Gm-Gg: AYBFou0Ql41xOFRlQoNl3puqRA4VpoHtMjvnHBkIDA1uO3Gzx4qc8lH+deji4M36Ax/
 JJq25m+RD0KO+UUYn7LtOpg6bIaAh+N6pbd+w3vfgP0sk25DYLMvKz0/Q+nmTi7+BkrVzt0HB6N
 GlZ7WKnhlGoqH2xhAgLajYUOBk+im5EDEt3TmVadlKjO/mP3+KJnqSoIobRkxQs+feOQJ90sOwk
 XDg1vPiBAsbg95YzQLhP1FcO45ctImO/Tn9ib2/fvaWc2L0dcNR4Adl1YeeJw==
X-Received: by 2002:a5d:5e88:0:b0:487:b4a:3f54 with SMTP id
 ffacd0b85a97d-4887175f936mr21375103f8f.29.1790597828029; 
 Mon, 28 Sep 2026 05:17:08 -0700 (PDT)
X-Received: by 2002:a5d:5e88:0:b0:487:b4a:3f54 with SMTP id
 ffacd0b85a97d-4887175f936mr21375078f8f.29.1790597827668; Mon, 28 Sep 2026
 05:17:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260923173021.317809-1-pbonzini@redhat.com>
 <20260923173021.317809-14-pbonzini@redhat.com>
 <58073b08-9f64-400c-b8a2-acd0baa4add5@linaro.org>
In-Reply-To: <58073b08-9f64-400c-b8a2-acd0baa4add5@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 28 Sep 2026 14:16:56 +0200
X-Gm-Features: AclHuK8BE0cWBUKfoBCCtyTco8GiDFDP37kvBeuXl8P2WIvOFwA8JHLuFT31wds
Message-ID: <CABgObfadcML=HsEfHXBg8ru5m2eByerxHZaKN8UOJQRoTSKTZA@mail.gmail.com>
Subject: Re: [PATCH 13/17] target/i386/tcg: add decode functionality for APX
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, chang.seok.bae@intel.com, zhao1.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.238,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Sep 24, 2026 at 5:17=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 9/23/26 10:30, Paolo Bonzini wrote:
> > +    case X86_EVEX_APX:
> > +    case X86_EVEX_APX_cmp:
> > +    case X86_EVEX_APX_pp2:
> > +    case X86_EVEX_APX_zu:
> > +        /* Only reached through EVEX map 4.  */
> > +        assert(!(s->prefix & PREFIX_VEX));
> > +        if (s->vex_l) {
> > +            goto illegal;
> > +        }
> > +        if ((s->prefix & PREFIX_EVEX) && !validate_evex_apx(s, decode)=
) {
> > +            return false;
> > +        }
>
> They're only reached by map4, so surely
>
>      assert(s->prefix & PREFIX_EVEX);
>
> is more appropriate, and the subsequent test for evex moot.

No, validate_vex() is also invoked for non-VEX/EVEX instructions.  In
that case, for example, it will raise #UD for opcodes that are only
the VEX/EVEX maps and not in the 0F map. See for example:

    case 13:
        if (!(s->prefix & (PREFIX_VEX | PREFIX_EVEX))) {
            goto illegal;
        }

which will reject an ANDN that is encoded as 0F 38 F2 instead of using VEX/=
EVEX.

For this patch, in particular, group1, group2, group3 and group4_5 are
shared between the root map and EVEX map 4. Some of the instructions
starting with F6/F7/FE/FF will call validate_vpx even with no prefix
and have to be accepted.  I'll add a comment

        /* Not reached through any VEX map.  */

for clarity.

Paolo


