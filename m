Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D17C35FFC
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 16:53:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuwfg-0004Q9-Um; Wed, 19 Mar 2025 12:53:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tuwfe-0004PG-Kb
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 12:53:34 -0400
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1tuwfd-00053Q-2E
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 12:53:34 -0400
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-476a57a9379so51668871cf.1
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 09:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742403211; x=1743008011; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=waSsS/j5VDDN8ocva8IGqDPUr4RAn4apsQ06isLSx/I=;
 b=ibqAzTRILcFbG1OlI3TqQ+2j5OwT7rGFJCcL3a2IIcIrebVBlDQaJhdWebqI7vXuaM
 dKlz1U5us+HOLXpUBHi8wWEXLiuUQ6P96sbVgHpbY/f5QJKJI2+XbWTjlFfx+X+rKYoQ
 tZfUzaXt8/aqYjjH0j5RNssFFqDDcRtXw3VFc2lae1Pqko/fhF8NrW0qxUcjpssqHGb6
 K9NF+vW7Pb/edMQ9TU3avT0fuLsHUqk2guXxQ4tnTfomBD+ywgwxU/iJTrY77BLkgyvb
 ZQRqvsAtV3r5LSSI+4+6Y/7YaTSXvP9P01+HMc9pYYN6qIo1tnHSi57dGr63/APTwI9Z
 oNNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742403211; x=1743008011;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=waSsS/j5VDDN8ocva8IGqDPUr4RAn4apsQ06isLSx/I=;
 b=VSILC8Qsj9zT89IwuRMd+yvoFxHo4NGS7DUnkRPv6gWTqUl3RxFMP43cQT0mZwfoVY
 UOEMftt0Ap0fvIlnbxkBCFAKlGwmikB0yjvSoP+Vw6azLz1DBCIIoHZMYifdVjQnXjC8
 hDlanWi8ZEG7z9xobrrzzVa6QaeKDR64tPcjeqgu4r/eRwW24uR2sePsyX6+akYzjNbn
 5BgX+gyWuEMAwYWF4qyD6wWCpzLgSD6PjI/tv2qv1cAqpRSsOF8ilqk63QTOKw1uJVCx
 OpG8eUYnG/j7xVfOH6Y2OCjrPYmIAWALsjitOAdt19ICb2CrTTZ0kFQEe6z2vvUBVEd5
 NGQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWH9HbiVHzBZUZJAwVLqymLFU46vacQsEZ2htsCb2SnABt1W6oorZLGCHl+JunDOqWsQfun9CJzbQHG@nongnu.org
X-Gm-Message-State: AOJu0YxOXw7X2FSdtsOHs9xa1vptsABn5FBDoDXdkkZoyFAXFcX58ZXI
 NuPup50dJrPvrKBvCiia31yfP5b+2PHSPgSK/aIOPYCGdxA717SQ
X-Gm-Gg: ASbGncvngt5MQ6XKafEqlnZWPgHC+lp227mfhlwB3BQo4WZs/Fi9hhkErS0H9uu7Ry3
 MFUqyMYlZ1hYfEVfUy8enkLiXcAvcVI6g5NIFqPF1ZhXxnox3NWh9ZGljXxx5ga2LN80vaF4Fh2
 f5jHYTt+bWF1a1/fxn3emhM7wnF3Q+2o9i5NyEi92C6/uHSZJNIdFYaCdjRFuaGnP6qHG0ON6ys
 gkuz2HzwFaDmnU3bx9XCFJRWcL8VBQpwJ38FWu2gHqVsOSXPOqUuS1wXVALxFK1MzbI52lA5AAN
 3w2j65LxwX6YCj+ZLSv8Spdi7lw4C2ZnLdgR9KpZTmr7Pky2rU88WqJimlZ9KA==
X-Google-Smtp-Source: AGHT+IHATgaGdpYK8FGYXYh5VCLaB2tglNj090FXyWeQ0HC6rHlG3op8ceAyYLbSso0VPKtYeYP7pg==
X-Received: by 2002:a05:622a:5145:b0:476:838c:b0d6 with SMTP id
 d75a77b69052e-477082e21f2mr55031831cf.2.1742403211500; 
 Wed, 19 Mar 2025 09:53:31 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:6000:a500:306:992d:4509:eca7:6f8])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-47705dab421sm14333821cf.36.2025.03.19.09.53.30
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 19 Mar 2025 09:53:31 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>,
 "'Brian Cain'" <bcain@quicinc.com>
References: <20250301052845.1012069-1-brian.cain@oss.qualcomm.com>
 <20250301052845.1012069-34-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250301052845.1012069-34-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH 33/39] target/hexagon: initialize sys/guest reg TCGvs
Date: Wed, 19 Mar 2025 11:53:28 -0500
Message-ID: <02bf01db98ef$71ab2990$55017cb0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIWUu77rEigiK0ljjjo9ZdCZqs5mQIRWHkNsvSuBzA=
Content-Language: en-us
X-Antivirus: Norton (VPS 250319-0, 3/18/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::835;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-qt1-x835.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



> -----Original Message-----
> From: Brian Cain <brian.cain@oss.qualcomm.com>
> Sent: Friday, February 28, 2025 11:29 PM
> To: qemu-devel@nongnu.org
> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
> philmd@linaro.org; quic_mathbern@quicinc.com; ale@rev.ng; anjo@rev.ng;
> quic_mliebel@quicinc.com; ltaylorsimpson@gmail.com;
> alex.bennee@linaro.org; quic_mburton@quicinc.com;
> sidneym@quicinc.com; Brian Cain <bcain@quicinc.com>
> Subject: [PATCH 33/39] target/hexagon: initialize sys/guest reg TCGvs
> 
> From: Brian Cain <bcain@quicinc.com>
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/translate.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c index
> ff881d1060..248ed60f29 100644
> --- a/target/hexagon/translate.c
> +++ b/target/hexagon/translate.c
> @@ -1295,6 +1295,26 @@ void hexagon_translate_init(void)
> 
>      opcode_init();
> 
> +#ifndef CONFIG_USER_ONLY
> +    for (i = 0; i < NUM_GREGS; i++) {
> +            hex_greg[i] = tcg_global_mem_new(tcg_env,
> +                offsetof(CPUHexagonState, greg[i]),
> +                hexagon_gregnames[i]);
> +    }
> +    hex_g_sreg_ptr = tcg_global_mem_new_ptr(tcg_env,
> +            offsetof(CPUHexagonState, g_sreg), "hex_g_sreg_ptr");
> +    for (i = 0; i < NUM_SREGS; i++) {
> +        if (i < HEX_SREG_GLB_START) {
> +            hex_t_sreg[i] = tcg_global_mem_new(tcg_env,
> +                offsetof(CPUHexagonState, t_sreg[i]),
> +                hexagon_sregnames[i]);
> +        } else {
> +            hex_g_sreg[i] = tcg_global_mem_new(hex_g_sreg_ptr,
> +                i * sizeof(target_ulong),
> +                hexagon_sregnames[i]);

I assume this will be changed with the redo of global resource handling

> +        }
> +    }
> +#endif
>      for (i = 0; i < TOTAL_PER_THREAD_REGS; i++) {
>          hex_gpr[i] = tcg_global_mem_new(tcg_env,
>              offsetof(CPUHexagonState, gpr[i]),
> --
> 2.34.1



