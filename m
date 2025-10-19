Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2F72CCD184
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Oct 2025 22:14:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAbeG-0001GL-3A; Sun, 19 Oct 2025 18:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vAbeE-0001Fw-1g
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 18:13:06 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vAbeB-0000qE-Ul
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 18:13:05 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b4aed12cea3so643837766b.1
 for <qemu-devel@nongnu.org>; Sun, 19 Oct 2025 15:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760911980; x=1761516780; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KK7D6YTSQZkeapuroTZ4yl/7gC/TPXja0qEFUPEUH9M=;
 b=XdKUV9GwaAHRiN70xUkgO7WyuGmmeOKM3HNzMNw995CKwL2SHrwqZH1VOrFRCjdsD4
 ARRV5AuKXGCAnPOP3uAUMgnYjbSAmN1WiBSt/Pb0reTILvYGcAvxP3AtgeJr2L9h9cAd
 cDXSgSv7ZG5OZiTwfCq5ONreascnpncBK9GpiOFDPVmXlNzz3P1QdOVbUWAg7cOu09Ay
 OC5dqJ/HO20KqH8UJ+kmWeidKq3mE/XenwUgCXfrpfzmX58ajjSzr50yZBouqD9LXXTf
 zIfqZzb6+YBrq7pLTpYdSaF86bkM1d8Vx5LLDqOq7Vi7Gh9kDMEBX1TDcewqe6+bUL2x
 8iag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760911980; x=1761516780;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KK7D6YTSQZkeapuroTZ4yl/7gC/TPXja0qEFUPEUH9M=;
 b=Ar54wTomMKlutgw9mAqmoES266bJPV8YyVCnywex6+bmFLLBNd0tkx8DeIpft5pYQz
 wVR3lQD4H4TLuvXNgVJTq/nIT2hnbGhx4H/q2ZzXMdodBVumBVI+tIMdG8DKhCIEU246
 k+xFqNt4HVkdWH6y8/+Okc2IKGf15Od8uGK0VRytW1Zk9znm1dnIk8sIFrOqQH6ZVUgb
 dsg+XSTqI87ww4H2RGosr30TqAyUCrKQneth6TtXePRl2m+Rmlj4xZnalXvJo3WJy4ln
 rZ8VrKwa4uTZuG0HZbn8rQACQtlxKAOxkKwpo41IjpURblRWYKT2QI5OWG2OVIG7LvGc
 Ivzg==
X-Gm-Message-State: AOJu0YwCEBYXvh6barXRwkwEefs9URIXsYVmoLQcZPDhhzaKvEWYuEE7
 C6r8GdOceuWp4xxHEIbVFhr0NC0NqevjfPji6guKhuqWnYL1ov0WszuAqA8SBXWD8ZA=
X-Gm-Gg: ASbGncsW2tOIO6OvkAqIBQuuDitVjUWhkHMmuQSHnKN/o66Qzfl3gsVTJAGTYCbcGSM
 On+nMLNd/2Cu14GuTlV4cXJ0+yYrSaUYS/n5Upi1KLgH+N0l/mv6nrnELHZv+1g+7yp78cSpkzV
 ICX9ZaSnes7IDrHzSAMY7N80T2NTfNZQ8exzsCUKp6aU5Uy7GvO7JvvZHNDCVpWme/TQSAuoJcl
 dCpv411VoXydu8epqJiwbv58N62jEXSqzXc/kysN9U3HJQRPtqRZhDzjYIUOC+Y/CtGTSLnU+bf
 nQoVRb0yuUSlZ+wnuK3P55A2nse97UHFHnXpG0bLqDQpUkMhbG/k3GFtXTPsVDUZ6uYIGPpskwM
 NpPHub7Yr9BKCYaqSgZyDxP3NfP9aLIpV1sSAFi1LDE/F69w/q0z2q+AGpCUTqtceUS5zqI7xei
 xm
X-Google-Smtp-Source: AGHT+IG16nRtmYMoQYTMm/Slxb+ynR6+K7tCMe3GCTo3TPIMdWwGg8ZAp6N36Ac123A6KaBflTLOnA==
X-Received: by 2002:a17:906:fe44:b0:b50:b508:d0e9 with SMTP id
 a640c23a62f3a-b6475125839mr1228631966b.46.1760911980430; 
 Sun, 19 Oct 2025 15:13:00 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b65eb526325sm600566966b.55.2025.10.19.15.12.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Oct 2025 15:12:59 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 662EB5F7F1;
 Sun, 19 Oct 2025 23:12:58 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 02/11] gitlab: drop aarch32 runner and associated bits
In-Reply-To: <cc5e4aba-7d88-4748-9368-cb8845c82150@linaro.org> (Richard
 Henderson's message of "Fri, 17 Oct 2025 10:56:19 -0700")
References: <20251016150357.876415-1-alex.bennee@linaro.org>
 <20251016150357.876415-3-alex.bennee@linaro.org>
 <cc5e4aba-7d88-4748-9368-cb8845c82150@linaro.org>
User-Agent: mu4e 1.12.14-dev1; emacs 30.1
Date: Sun, 19 Oct 2025 23:12:58 +0100
Message-ID: <87h5vu7d79.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62c.google.com
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

Richard Henderson <richard.henderson@linaro.org> writes:

> On 10/16/25 08:03, Alex Benn=C3=A9e wrote:
>> diff --git a/scripts/ci/setup/ubuntu/ubuntu-2204-armhf-cross.yml b/scrip=
ts/ci/setup/ubuntu/ubuntu-2204-armhf-cross.yml
>> deleted file mode 100644
>> index 0cc34cd10b9..00000000000
>> --- a/scripts/ci/setup/ubuntu/ubuntu-2204-armhf-cross.yml
>> +++ /dev/null
>> @@ -1,127 +0,0 @@
>> -# THIS FILE WAS AUTO-GENERATED
>> -#
>> -#  $ lcitool variables --cross-arch armv7l ubuntu-2204 qemu
>> -#
>> -# https://gitlab.com/libvirt/libvirt-ci
>
>
> Had this file been missing from tests/lcitool/refresh?

It appears to have been added by hand. In an earlier patch series I had
to make some changes to lcitool to be able to generate yaml:

  https://gitlab.com/stsquad/libvirt-ci/-/commits/cross-yaml-support

>
> There appear to be no more references to ubuntu2204, which is still
> present in the refresh script.

  lcitool dockerfile --layers all ubuntu-2204 qemu

points to:

  tests/tcg/docker/dockerfiles/ubuntu2204.docker

we will bump those in due course although probably not worth rushing
for 10.2.


>
>
> r~

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

