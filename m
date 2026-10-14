Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9AFECC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 06:11:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGsCg-0001sO-B5; Wed, 14 Oct 2026 02:11:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xGsCW-0001qw-2q
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 02:10:56 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xGsCU-0005xE-HT
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 02:10:55 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-48c6f764f82so20279f8f.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 23:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791958253; x=1792563053; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0DZf+T2NVIDXDOOVWsPeAnkidXmSVMy6au56KI55O/I=;
 b=Vji1INTsuynsF8ix6A4ALaiOX2TD2JzNC/JKWoi0xAeYpFPnBJtS4imii7UhtTzSQZ
 2r9trYECi/dU0hoX3BC03t06l/nd43KrznATMcfVf2BjhA1Oc/bWDFsq//iqcFdE5qIq
 SLeKkNmGQlOP2o2nAZag4TbTBntx8DkTGZ9P+sqeT5MgXH4ENNMyDdzOPgX3m8DKu9Oz
 JlOOyGnIoSBrk6DBYE71xOyUVflPfJIIItLXhph8QNTDAV0mydGuEGWM7R8GEnIZHW5f
 Z/P26Q6E4xdjKcRLnnWiaI0CNeQQmj2EgVHJlKmofyeecRlzA6otXcSHxuqOzV1x6ZTu
 XUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791958253; x=1792563053;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0DZf+T2NVIDXDOOVWsPeAnkidXmSVMy6au56KI55O/I=;
 b=BzVsT4qIXJEQNNquC6YRYy3bn6kjTLay9IKVH1jW8V8xHxtO/U/P/BZqm3YuhGHGPz
 W9FGZh+dkzJYq2Pi5Xhweki+NjRG+KNSmm4btUe/5LUBlcOsEDGAdoj1/wd/EKGcP41e
 ZBN8cQSx2z3/XC9miC7GZEdLndI1adULe+4lFG6poRH5ufeX70X/7oh885A29ifV2rpL
 +bEnAgP9LzW1K3j/lV/iPPsPiuNCwo1fk7NYLuh4D9RqAJj/aYAa91WP+Drrrax+Uuzc
 CFXXl1uct3b8KEnvonhCAZ+Uq1IjtXemfd+//hVEoO56jo6ygHnphJHDxnSLc++hO+7i
 GgNA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy4NkAClUgsrLENPmZOhQT9adp7txLupPDpw/geLQql/chaWmDtu3cyDZqeW1oMWFoZ0uo4LeoUCaAQ@nongnu.org
X-Gm-Message-State: AFq9FYLQRsS3JDKSS51QiKBO1ee3A/ZF7SG0+8G6opLbe8J8TFk/8wEN
 h8BM29eUIbItCFCCYPXZpu3mD673MDT3k44YYYEmyosUZBh96tV86j8sELVasvpAzU0=
X-Gm-Gg: AYBFou3JVyM13F/kOHSBKxtwD8elO8F/BS+ZdwuJgqUOt9k91OufeFhd48X/k9DRoev
 XwEVikAFwbcafsSnc0GETcZuC94FbwI701uJCWbLk5CANDWyq2Y61qz0Mo8bqEGRUsoB8hgqKuU
 CFWeHTeLRHsiWTG0gqR2vrceyyqBXqODGz83goEoOTAgV41L8AagdBpNoczK74hKEZBrOWupzpb
 4BDiyUz7tRFbyypcCcJNkCRT1Niz6E5kRUofA3BiMco5KMeXvIMnnJPNfokCRI8v9GtWvC/uNN5
 My0g0teTceohTTE76XqdfSziyGLyQARkQ7qG5f/gXQIqM49HAUVSGm5RZydLI+Qw6RTTiKhAwjy
 i0HeMsxb7LJ8ZQrTZ6iVlhWCgiYNHMwXWETlQuO3VhcmlqvVDyo0GGxGAXSP2xmzsr6TqayTxQD
 JOJR+t+zLlRbbfjknMHQ/rWfRfFhDx/GI3A8PLBozI5gZWadYB4hSUqRQ4qO2wIpkAbVFWkq9rM
 YjM/OP/fmm1H9kT7WpdFlIpZFv01qhhkvXNRbrBWLiN/nnlUuce8HuheBrtRV6GjSs=
X-Received: by 2002:a05:6000:2993:20b0:48c:4442:54e with SMTP id
 ffacd0b85a97d-48dbaae710dmr21112092f8f.30.1791958250848; 
 Tue, 13 Oct 2026 23:10:50 -0700 (PDT)
Received: from [10.86.151.227] (ip-109-091-152-129.um37.pools.vodafone-ip.de.
 [109.91.152.129]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de3f7f8b8sm8075976f8f.35.2026.10.13.23.10.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 23:10:49 -0700 (PDT)
Message-ID: <e9cac01d-468e-4f9d-9288-024ca7574114@linaro.org>
Date: Wed, 14 Oct 2026 08:10:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386/tcg: Clear cc_op_dirty after UCOMI
To: Hungyu Lin <dennylin0707@gmail.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20261010192520.37355-1-dennylin0707@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261010192520.37355-1-dennylin0707@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/10/26 21:25, Hungyu Lin wrote:
> A self-XOR can leave cc_op_dirty set when UCOMI keeps the CC_OP_EFLAGS
> selector, causing a redundant store to cpu_cc_op. The UCOMI helper
> already writes CC_OP_EFLAGS, so clear the dirty flag after assume_cc_op()
> to avoid emitting that store.
> 
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
> ---
>   target/i386/tcg/emit.c.inc | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/target/i386/tcg/emit.c.inc b/target/i386/tcg/emit.c.inc
> index 531398d..918122b 100644
> --- a/target/i386/tcg/emit.c.inc
> +++ b/target/i386/tcg/emit.c.inc
> @@ -4914,6 +4914,7 @@ static void gen_VUCOMI(DisasContext *s, X86DecodedInsn *decode)
>       fn = s->prefix & PREFIX_DATA ? gen_helper_ucomisd : gen_helper_ucomiss;
>       fn(tcg_env, OP_PTR1, OP_PTR2);
>       assume_cc_op(s, CC_OP_EFLAGS);
> +    s->cc_op_dirty = false;
>   }
>   
>   static void gen_VZEROALL(DisasContext *s, X86DecodedInsn *decode)

This is definitely wrong.

If there's something you're trying to fix, explain that.


r~

