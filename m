Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A745C624D4
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 13:30:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1OYl-0006r5-1E; Tue, 01 Sep 2026 09:29:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x1OYk-0006qv-4M
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:29:54 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x1OYi-0001ch-Hd
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 09:29:53 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-499ac87c92bso9782175e9.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 06:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788269391; x=1788874191; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=s2oIQOZni54uLMnNUuval+J77iSEwWjyXcVRz76jeT8=;
 b=Ye1jHCQt3woYwOR+VOI9H//vOsqmZ/VcWvt1SH6RhJIYsXGQgix/dL8T4ryd+W8hmG
 OGUgGf8x04w/kJCoBs/kE3XntqCXfiDckfofBIjf+oMJJp0V8tp305iqGqJudFjnBHa6
 gyzkSNg9LRSoNipZ2SYkhbJjptsRXbJHtYSUmiz3KCodOO7gGz00IpTqwBL1lw2zdDb8
 Lm4MP3iLvoC9bV/vpV6z6r033EG4XNR+m7UGTZRfGma1J+nkgRRPMlS2pYFokWc7nxkn
 BOSQiXAKelo4+GvWXmVggZC3iQFbQ3+tu3go6Ik0D1X9MlS72IvzfV2os8c+BwhPYqkQ
 Gp1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788269391; x=1788874191;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=s2oIQOZni54uLMnNUuval+J77iSEwWjyXcVRz76jeT8=;
 b=d6BIH1DMZ/jylteozgo0GtGVFKboNYZW5SqdeVOktE19m04zVPj1ogmbiUY3xcdhk6
 4wacIYxPKmfpFBmxwb5kYZAp2sjyPshWWQxLSgtKSqo/S++GsewFxCzsCqaK2tBaijxP
 DArsxTM82fFoQDJV4+Y13nB2QHiFgJi+KYd4jJSXZTPVnJOzInRv3JUqWzkUPlJjxYXF
 juHpfS0Z9IQZUJNr8LpYDp7UTVOqRtEXYgXB8avg8E9Uxsd1bjYBZ2Dcs3Q7MbNv1Ojc
 VlgyiSTpwBoZXfb4Eg4V6fJ8m6bcvFv5QyC92Z7rPhkmSt7QMqY8U2XxLSiGQRVXzr8H
 IM0Q==
X-Gm-Message-State: AFuF++nQKmrvkp39kwh323rYexu8gqM1SuG1J/A839zxZIaHq53J/w7O
 YAiLJu291GvvBOhL437aGWjDHFL/XxT5jp2pg77YAXwD8XXVu73wQ8m05wSG4eRQsSQ=
X-Gm-Gg: AR+sD1187y6pVQjPeMqfC5HetjFDTAqHZv+rlmj5EYe1b/6UlEdIEGdZh5IMJyhNOS3
 Alr+pIuYRt3anToyp7As8jniG8avEQIYhaCVdNUlg9D6ceq3yrD5GFhYQJH89nZ72Q8dB6wj7sA
 2jZ0kK3DxGGMvcisCLFVmPTtl+9pu0k3o1R2AiHbi0GzjsyOZuncXYxQU+Hhc7gAgC2JbmvNzjE
 obcBOVn1K7EWo9p3F6NBKoc44TSOp31H1yrcebIVJ+939WikQS4ZL5a+AG04GIsOlqIanwicL5N
 g/CDeschbm1nuZr1X6BDBT/Y4eCzaPcVKsSIEUdM4XPcDFyjEZ0MgoM9bO+yMYuZTSg9sBsYbIz
 cx/iA/KSH+JPZb/kG4NREo7lN406yV58Z4OK0cg+XWoNx67/eV5IHQBlwRcupmdKWDr/UETLTdL
 OCBX9TjRXtiBBEBU8MQ2If8on7iX+EbBzKhKincKfqJECP0PS04kaxYYde8Fsy
X-Received: by 2002:a05:600c:1393:b0:49b:12c2:104f with SMTP id
 5b1f17b1804b1-49b91c2660amr482452375e9.1.1788269390567; 
 Tue, 01 Sep 2026 06:29:50 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce18dbae2sm23926445e9.13.2026.09.01.06.29.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 06:29:49 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5FDD95F829;
 Tue, 01 Sep 2026 14:29:48 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Stafford Horne <shorne@gmail.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Ilya Leoshkevich <iii@linux.ibm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,  Palmer
 Dabbelt
 <palmer@dabbelt.com>,  Richard Henderson <richard.henderson@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>,  Helge Deller <deller@gmx.de>,  Max
 Filippov <jcmvbkbc@gmail.com>,  Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,  Brian Cain
 <brian.cain@oss.qualcomm.com>,  Song Gao <17746591750@163.com>,  Yoshinori
 Sato <yoshinori.sato@nifty.com>,  Laurent Vivier <laurent@vivier.eu>,
 Nicholas Piggin <npiggin@gmail.com>,  Aniket Sahu <asahu1x@linux.ibm.com>
Subject: Re: [PATCH v8 039/105] tests/tcg/arm/fcvt.c: use raw opcode for FPRCVT
In-Reply-To: <20260827221506.91574-40-pierrick.bouvier@oss.qualcomm.com>
 (Pierrick Bouvier's message of "Thu, 27 Aug 2026 22:14:00 +0000")
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
 <20260827221506.91574-40-pierrick.bouvier@oss.qualcomm.com>
User-Agent: mu4e 1.14.4-pre1; emacs 30.1
Date: Tue, 01 Sep 2026 14:29:48 +0100
Message-ID: <87pkyxumk3.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> fcvtzs d0,s31 requires fprcvt support in compiler, which is only
> available from gcc-16. Since our debian-all-test-cross container has
> gcc-aarch64-14, this test will never run in CI.
>
> Replace the concerned instruction with raw opcode, obtained from:
> $ echo "fcvtzs d0, s31" | llvm-mc-22 -triple=3Daarch64 -mattr=3Dfprcvt --=
show-encoding
> fcvtzs  d0, s31 // encoding: [0xe0,0x03,0x36,0x9e]
>
> Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

