Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51AD8C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 14:35:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA8WE-0007wI-Ik; Wed, 30 Apr 2025 10:34:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uA8W2-0007oP-NX
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 10:34:26 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uA8Vz-0008Aa-JR
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 10:34:26 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-736c3e7b390so7544780b3a.2
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 07:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746023662; x=1746628462; darn=nongnu.org;
 h=content-transfer-encoding:subject:to:from:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rW18o9E6I59ZEOmutdllxFRIpDG5spcQCfrVFA1LMoI=;
 b=Y+ao2sarFPpdWb1Auy+q3+yJqLKaQXusIvzNTzujFKkj+HpKgZJKyel5p7l+yWTRrO
 hIOQFu7EULIo+jpSy/ElWUT6DiQvvk1EKVf2P0ogly1sfVmR3a2i5K81ZGlQ5rKLD5+e
 53zptjx76hLtfr3kDnnj8djN37K2qVqZddZCbosZyG+Sa6RL6UDdIAIMoWXbG6t1PM9l
 8xKZf7uC7VvOrlKjf48EWSIUQUE4DMKKA3Lr7MaXh1s42hJ72aAbAKUEluKrWtEoulDo
 eri7QWf5aipwSIjsH9pypmRHov5ss/ebBT1ibq1VRWDQzgsLDXkK5KFXcyMsyOLGuWNt
 60pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746023662; x=1746628462;
 h=content-transfer-encoding:subject:to:from:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rW18o9E6I59ZEOmutdllxFRIpDG5spcQCfrVFA1LMoI=;
 b=tP41EBbT3zv6n1cJ9RS7zfSNGFjUWZ+aHN6N5axgTMNreYDWOORpzYPC0BCJxQpxAr
 APvMQ8OWNRwwEsQhNn0eixPwyoKUq1zUscluNybs1z9U0npABLgbeDFUKb0ftTke2bXM
 nEQMnC8M6WF+hjNdc8lMRyp0KO8mfyCUeGdy3XkEzRI8yibmWxVO5aZ1qjjE9Ac68JFS
 fd1rDoGypMDtJ41GhPmjw2Yy5ENEjDwwmXTkq4jIgbwFG9COWMy8YqNhR/128CXAs3JX
 ESTIoV7LVmwIqQZOMKIkucXF6RLJllPgsUAAZ5kJBor2T6FePMQGLO+OGuE624j5zqZX
 ClwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWM19xeHamHxXOFCVD4OgIcprMI5ioG93+vogPHkPu4Fq1mjb8f1dacvASmM1xKgzjxvr2Nv6pUS+x+@nongnu.org
X-Gm-Message-State: AOJu0Yy+h2EEXEIXdMUXSlBB3W1dIL9Z+FBsm1gkmQK1mtFvb7CTFlts
 XBoFF/J5C3fAFL76/0b1YvmukeNIUziA0bzIy0Sh0tz47g1SEdi/JbgjxdfSNJrz4vwLRpTG172
 3
X-Gm-Gg: ASbGncssB8fTmZ8e19cDDqdE+Yxur1Gn5alP8corhmUzjFGQzX6uMHjjY1QZcmmw0k8
 USWMozZUPLutA44uvO6+R4OWTecpM6HUdAH5B+5j+DnA2r8825+bfaEGCo0SJXMfz5eJshYN01j
 GhVdroBNE8Tn11P9ZShtedr7wNU0/AYZm0rjqaPcNWLxoPVsPcmdu04XpW8ZDw9L7pU2m4xjHm/
 FlLVvBa+7d4f4e6RjtNE/7lvrvftjPA8JzHSfyjlpQWP82fUBdOLH9/q+5kIucdn+ysOG7hTnI7
 HrmljHrFnog5H0ClcI08FQKWCY/q63F+FzYsnCI6MQ8v29wZ4p7P+w==
X-Google-Smtp-Source: AGHT+IHam+dPUoVpBk2Jp7no1XhjrY0NaqMJ3gu33Bp/pYdYXzVv1NgK/diDW11RYnFKOGv7TsHpZg==
X-Received: by 2002:a05:6a00:21c7:b0:736:32d2:aa93 with SMTP id
 d2e1a72fcca58-74038abf64amr5076200b3a.20.1746023661939; 
 Wed, 30 Apr 2025 07:34:21 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74039a5c064sm1685842b3a.123.2025.04.30.07.34.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 07:34:21 -0700 (PDT)
Message-ID: <c83e0d26-4d1b-4a12-957d-c7b7ff4ba1b3@linaro.org>
Date: Wed, 30 Apr 2025 07:34:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Functional tests precache behaviour
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
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

Hi folks,

$ ninja -C build precache-functional
2025-04-30 07:23:20,382 - qemu-test - ERROR - Unable to download 
https://archive.netbsd.org/pub/NetBSD-archive/NetBSD-9.0/evbarm-earmv7hf/binary/gzimg/armv7.img.gz: 
HTTP error 503
2025-04-30 07:23:23,131 - qemu-test - ERROR - Unable to download 
https://archive.netbsd.org/pub/NetBSD-archive/NetBSD-9.0/evbarm-earmv7hf/binary/gzimg/armv7.img.gz: 
HTTP error 503
2025-04-30 07:23:25,870 - qemu-test - ERROR - Unable to download 
https://archive.netbsd.org/pub/NetBSD-archive/NetBSD-9.0/evbarm-earmv7hf/binary/gzimg/armv7.img.gz: 
HTTP error 503
2025-04-30 07:23:25,871 - qemu-test - ERROR - 
https://archive.netbsd.org/pub/NetBSD-archive/NetBSD-9.0/evbarm-earmv7hf/binary/gzimg/armv7.img.gz: 
Download retries exceeded: skipping asset precache
$ echo $?
0

Since we silently skip the asset precaching, how can we identify that an 
asset is not available anymore (temporarily or not)?
Should we rely on test itself failing when trying to download again this 
asset?

Regards,
Pierrick

