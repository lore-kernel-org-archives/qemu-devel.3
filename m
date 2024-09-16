Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A5EC3ABA2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 13:09:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqBTH-0005GF-Q0; Mon, 16 Sep 2024 09:08:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sqBT8-0005EC-J1
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 09:08:42 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sqBT5-0005tU-O7
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 09:08:42 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42bb7298bdeso43094055e9.1
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2024 06:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726492117; x=1727096917; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rZcRwEkPG6Z3bhEfmouVosmtKdibKV8+JP7hxfx+GY0=;
 b=u+0hKbBddgolsFmM5GqN03EnvZRzDsBh6DyhDDlDIYvT380bI1poypmrYOcA6x2IR1
 Ql4OyRJ2md1u8Dg6THrIc57SvtuFK0CPgN9khWIYdDYM9R9rhoZ9cAhUhhaHW91L3/H8
 IqkPj/cUdopgsJX+QnHDA2hM9qQ90NVsz+f5KTBxjLi0evYApUkpPfATMu58C9GDP3SG
 raBnIwQv1hgTiMij4PofFun23CJgcojVBAxH6QN2AWUphkO1FHbgBPHW7fGT1CfQkLdc
 b0OJKEe9jT8JshGFXGP0ozVDDow89qhP3tbVGscw7HiMX+ssS1IAchuXTjnfG0/F16Ps
 CETQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726492117; x=1727096917;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rZcRwEkPG6Z3bhEfmouVosmtKdibKV8+JP7hxfx+GY0=;
 b=woAILV0BOFJiy4Pe/V0kyhfIYNCCjnh1kt7MgeJQsysBq2lAJPumdTIkIQv+Ay1hbZ
 T2bJx+zzyYuLbqno9y9QsYdNAyR6d/zecu83vpRv7CfBFwMqE+XF+PZdyHrlw7QkGqLF
 RGy1SxMtCw/33ds0vhIlLSyCwN9h1JFDoyr8s5L43Qoe4wkQ2hF8u8eSqrIFDULgkAqT
 pQGrQ5kVCIK5MHnqEgoO5UhYgaQkgabD233qtXP+AoePmxarG8YtwVj/tthXVu5FG1ZI
 NaHysEIJj6jGOp7PmpOvOEDLbgAk75TTj5HNf5abiUacHe8fhkZrulSv5yfnBJwHcl6U
 s6Wg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXB5SWz8Cdq1nwzIQRtyjP4vnexFOCk0nu3IQf7McePQa+Di+tmmh/3BsKQXx3+I2Uy9E7wKKQzjQ2m@nongnu.org
X-Gm-Message-State: AOJu0YyIdCm1Vk6/imjkTmVa4Lsw/pAUCQQbkWVwMDwY5MDdfpUfKbPO
 /HYJXk6CJ+r7rBjGTGBJOPSs+GIRXaZLPNW1PVX+gw8+t1LQc5YtsEiIAW5upt+LZgJ5xr/ekD9
 kJT0=
X-Google-Smtp-Source: AGHT+IHhpRiIC88afnj7rH2DH6IF6/UIst3jLkh3FGnbB2cy8LWeWYOEQJOFycmqcQQcHy+SamvulQ==
X-Received: by 2002:a05:600c:1e0f:b0:42c:b995:20db with SMTP id
 5b1f17b1804b1-42d9070a50dmr112495335e9.5.1726492116422; 
 Mon, 16 Sep 2024 06:08:36 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42da24274d4sm76983015e9.46.2024.09.16.06.08.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2024 06:08:35 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AD31E5F87D;
 Mon, 16 Sep 2024 14:08:33 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Brian Cain <quic_bcain@quicinc.com>
Cc: Brian Cain <bcain@quicinc.com>,  <qemu-devel@nongnu.org>
Subject: Re: [PATCH] tests/tcg/multiarch: Define _LARGEFILE64_SOURCE
In-Reply-To: <0298a6cc-2c75-4cb9-8f9c-146c0173fc31@quicinc.com> (Brian Cain's
 message of "Mon, 16 Sep 2024 07:45:38 -0500")
References: <20240907023924.1394728-1-bcain@quicinc.com>
 <0298a6cc-2c75-4cb9-8f9c-146c0173fc31@quicinc.com>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Mon, 16 Sep 2024 14:08:33 +0100
Message-ID: <871q1jhhke.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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

Brian Cain <quic_bcain@quicinc.com> writes:

> On 9/6/2024 9:39 PM, Brian Cain wrote:
>> With newer clang builds (19.x), there's a warning for implicit function
>> declarations and it rejects linux-test.c.
>>
>> glibc/musl's readdir64() declaration in dirent is guarded by
>> _LARGEFILE64_SOURCE, so we'll define it to fix the warning.
>>
>>        BUILD   hexagon-linux-user guest-tests
>>      /local/mnt/workspace/upstream/toolchain_for_hexagon/qemu/tests/tcg/=
multiarch/linux/linux-test.c:189:14: error: call to undeclared function 're=
addir64'; ISO C99 and later do not support implicit function declarations [=
-Wimplicit-function-declaration]
>>        189 |         de =3D readdir64(dir);
>>            |              ^
>>
>> Signed-off-by: Brian Cain <bcain@quicinc.com>
>> ---
>>   tests/tcg/multiarch/linux/linux-test.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/tests/tcg/multiarch/linux/linux-test.c b/tests/tcg/multiarc=
h/linux/linux-test.c
>> index 64f57cb287..4e0e862ad9 100644
>> --- a/tests/tcg/multiarch/linux/linux-test.c
>> +++ b/tests/tcg/multiarch/linux/linux-test.c
>> @@ -17,6 +17,7 @@
>>    *  along with this program; if not, see <http://www.gnu.org/licenses/=
>.
>>    */
>>   #define _GNU_SOURCE
>> +#define _LARGEFILE64_SOURCE
>>   #include <stdarg.h>
>>   #include <stdlib.h>
>>   #include <stdio.h>
>
>
> Alex -- what do you think about this one?

Looking at the glibc headers the LARGEFILE stuff seems to be mainly
about cleanly mapping readdir64 to readdir. I don't think we are trying
to exercise 64 on 32 here so we could do:

modified   tests/tcg/multiarch/linux/linux-test.c
@@ -83,7 +83,7 @@ static void test_file(void)
     struct utimbuf tbuf;
     struct iovec vecs[2];
     DIR *dir;
-    struct dirent64 *de;
+    struct dirent *de;
     /* TODO: make common tempdir creation for tcg tests */
     char template[] =3D "/tmp/linux-test-XXXXXX";
     char *tmpdir =3D mkdtemp(template);
@@ -186,7 +186,7 @@ static void test_file(void)
         error("opendir");
     len =3D 0;
     for(;;) {
-        de =3D readdir64(dir);
+        de =3D readdir(dir);
         if (!de)
             break;
         if (strcmp(de->d_name, ".") !=3D 0 &&

Does that work for your clang case?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

