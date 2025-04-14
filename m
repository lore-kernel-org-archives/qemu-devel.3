Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCD4CC369A2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 17:20:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4NTN-0003dm-QQ; Mon, 14 Apr 2025 13:19:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1u4NTK-0003dI-Kj
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 13:19:50 -0400
Received: from mail-il1-x12e.google.com ([2607:f8b0:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1u4NTG-0005Mo-Ts
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 13:19:49 -0400
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-3d5e2606a1bso40676225ab.0
 for <qemu-devel@nongnu.org>; Mon, 14 Apr 2025 10:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744651183; x=1745255983; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=x26nbY1Zbe4ifJdomd9EjNMKAr25Q9IPBwQ87THCRWg=;
 b=PoBqCq3+PLXzudyM0abhI7i1nsp6ydaeUbRA0ilep/T3zThv9h714QwSjU3RC2c0W6
 7kdPgC08c+XBOhiO6hZDNOjvqJJ1VMca55DQLIU1ZFD0AmQuEqEL10rvdjNCIjmSeDvE
 7EfMcrzYgjaj/MLZ8t7aIR/KNSrmTvViAn98mhJU6pgQzvnSIpg7LWHHhPjUaCy+WEj5
 xFlyWdP9Wug/Z+ca1pr3Wo/l3RMbAwgAwFpp457v3hXB5f1/Z4WQJZ4gMkMBOQ3+feZh
 ih/PRzYOEFQrOxukKVCpNNLz/x+7vRxsEriH7K+9cpNSpNszDkyeyShASsLD1RNgEQMG
 hkMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744651183; x=1745255983;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x26nbY1Zbe4ifJdomd9EjNMKAr25Q9IPBwQ87THCRWg=;
 b=ermy67jKd8yNrovFMSYEjn9zrqb843/hawAPF+bNO4FDbEKvzS9OzvjsZ7yWejkz+O
 Lt/fOpRqAX+u8ztZcKwr8TyEyYIDpXATrOjx8maGwu9dXnLOG1QtLWez0EFj80M6NmfS
 ss0K4dKi6QirKkuUGJsTMhZMqVW8SJp9dyA8r85CjwG8tY7MAfK/OYER8XkmdJSHsJjb
 vHpdymzbcBZ8XnqUbRUwHgInI5BMMzLtmfUHwgckZb3TstbCpsYyqt7eV7G4n/bcvASf
 TUqfOitiGqJ1vxmAneyD1zre9dqfMBVlhOD/8Lif1FN0bkKeDW4CpTGfa+1ERZrsrCCf
 kOxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/rXM9w9nTJOfYKG5ttgJGOiWtoCF+WXhho3z1AlSC2vGqTaoqVql+FpGSvBt9gTKg2pwGDJVUmeEq@nongnu.org
X-Gm-Message-State: AOJu0YyWlggXQaRGGFWYVdQZv3L9ehhu5iJZ8ctLlSswdHIApVI4sI5E
 9AKyXdClcOYzvrou5PsLtTfpwgS7l6lfjT104BDwG252LhLlC2VJ
X-Gm-Gg: ASbGncvcynIps0+ZS05ihcj9caJe+J2fAtNKzLJuhR1WMslCN+tpuClM++9EtY4WbKm
 oeBRPe/ffH89+sAisvmhuNyzAE9xypxyx6OJIakDZkPWiAw/Yw876Pb/8hyc4MS2de1e9nLXsrH
 KW0SWcYaLmkZskw5QCnCPaZIXrhhZIwotgnIzxF4wq/7MYlhxHuiR6sGBRrqQErbmmbiq5Fn9Xh
 d0yJVp7lqVw1UcfdwZgGIQJo8wDnbFp0Db70VeMiFy1SfHd+wEwfRADTReTulY/u9GdeLiRFQgb
 MFoyDXAKVoOtM0MygjKcbg6k6UEG/+Lgmgtlk2TRAkyF3zhl3VLoIUsZrd6640Va731B8c08AYs
 =
X-Google-Smtp-Source: AGHT+IHUGNkHLL44Qi7BqNZIc1jfCyNCbTt3fgVMmm3EsJWkbP5Io6yczp/iwbk8/36XzftlDfC/7A==
X-Received: by 2002:a05:6e02:4515:10b0:3d4:3d5d:cf7e with SMTP id
 e9e14a558f8ab-3d7ec26b6dbmr83162875ab.16.1744651182966; 
 Mon, 14 Apr 2025 10:19:42 -0700 (PDT)
Received: from DESKTOPUU50BPD (c-67-190-160-7.hsd1.co.comcast.net.
 [67.190.160.7]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d7dba85249sm29481725ab.27.2025.04.14.10.19.40
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 14 Apr 2025 10:19:42 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <matheus.bernardino@oss.qualcomm.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <marco.liebel@oss.qualcomm.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>
References: <20250407192705.2605614-1-brian.cain@oss.qualcomm.com>
 <20250407192705.2605614-6-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250407192705.2605614-6-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH v3 5/5] target/hexagon: Remove unreachable
Date: Mon, 14 Apr 2025 11:19:38 -0600
Message-ID: <058801dbad61$68ff5b00$3afe1100$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFxbseScfkce8xHjxBW05Q6egvQNQHyCSmdtGhRL3A=
Content-Language: en-us
X-Antivirus: Norton (VPS 250414-0, 4/13/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::12e;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-il1-x12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
> Sent: Monday, April 7, 2025 1:27 PM
> To: qemu-devel@nongnu.org
> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
> philmd@linaro.org; matheus.bernardino@oss.qualcomm.com; ale@rev.ng;
> anjo@rev.ng; marco.liebel@oss.qualcomm.com; ltaylorsimpson@gmail.com;
> alex.bennee@linaro.org; quic_mburton@quicinc.com;
> sidneym@quicinc.com
> Subject: [PATCH v3 5/5] target/hexagon: Remove unreachable
>=20
> We should raise an exception in the event that we encounter a packet =
that
> can't be correctly decoded, not fault.
>=20
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/decode.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/target/hexagon/decode.c b/target/hexagon/decode.c index
> b5ece60450..1db7f1950f 100644
> --- a/target/hexagon/decode.c
> +++ b/target/hexagon/decode.c
> @@ -489,7 +489,6 @@ decode_insns(DisasContext *ctx, Insn *insn, =
uint32_t
> encoding)
>              insn->iclass =3D iclass_bits(encoding);
>              return 1;
>          }
> -        g_assert_not_reached();
>      } else {
>          uint32_t iclass =3D get_duplex_iclass(encoding);
>          unsigned int slot0_subinsn =3D get_slot0_subinsn(encoding); =
@@ -512,6
> +511,11 @@ decode_insns(DisasContext *ctx, Insn *insn, uint32_t =
encoding)
>          }
>          g_assert_not_reached();

Why leave this one rather than raising an exception?

>      }
> +    /*
> +     * invalid/unrecognized opcode; return 1 and let gen_insn() raise =
an
> +     * exception when it sees this empty insn.
> +     */
> +    return 1;

You should set insn->generate to NULL if you want to guarantee that =
gen_insn will raise an exception.  A better option is to return a =
special value that indicates "invalid" and have decode_packet return 0 =
which will cause decode_and_translate_packet to generate the exception =
before generating the code for any other instructions in the packet.

Do you have a test case for this?

Taylor



