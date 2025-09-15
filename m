Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0979CCAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 18:28:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyDvX-0004CX-Bt; Mon, 15 Sep 2025 14:27:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uyDvR-0004Bo-S1
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 14:27:42 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uyDvC-0001fj-PK
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 14:27:40 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3dae49b1293so2574018f8f.1
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 11:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757960838; x=1758565638; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EGm/bhCmfi0gAsnFJoiK0zZcJF0GbW+s5NjoEbldvDY=;
 b=ArUy3n9eXUrMBlEBamsOnpC5Xh6+B6+jishFVp0Gr8v+jEY8V6a7Djz6//AhQH+mMn
 8loi1Orz1lk0+CNzY6R3MHp3TNGuXG2dlWWZVVRZuTAMj83bw5AfLe4t0d2tE0aksipy
 uTeo/bYeJc5Xu+II1O3jFEdm1lTUj6ClZeZfsRbrXM7pClVhfdxRexgYz3HBXA5hEK5e
 O3WkLYYyeUR57LrUQFmCIEZ3NMASmyAfCluAW1KkFo/+nbwVz4vjMJlES0Xy7T8PT6MV
 9VotXLq71/y/zgUCGx31BCiX0yLg5vCIPcpqUBKqmvCLdjC2+3mnYE4nVk4N/0sqshS6
 yA5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757960838; x=1758565638;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EGm/bhCmfi0gAsnFJoiK0zZcJF0GbW+s5NjoEbldvDY=;
 b=G5sIhGJoApS5mvS+tBygp2lC/jxYkVpotLxSoibie9shMy1NSRgL7liBdDCUeRcUMJ
 SPYQcgkWiZjOPwB3NlrrsfoIxTa3zCDhgGwwL+VpJIouRwvpwmP9XhbatteY3I5FxTED
 QyNwe+vrZNJf4HM0yZZ7xvJu9AVSf8d0pfy3iNS6lGn1S7Ri2qAY+XLy8aeAZVxntW5X
 zYrfC7JsmP2AumAnAtrSaUcM23CHLbRLPQAEJEoywqdNTIHJZ6dkilklgsR9Jol4cw66
 2vVni326GZlMqyPppuYKL5xFTKIjpE+/7zVKYg6/Dq1b36O2ly4QpopXx0Xekr30EJvi
 se8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3RhKQHZNLZHFFQlULpLQRe0l7s8FJfG3eR1C0gYZ51ftdntAV93Tbc6BGeL71BnezIAIs0x6SHKEi@nongnu.org
X-Gm-Message-State: AOJu0YxPkrgts5jY2TdaTW/LQ35pna/n0ZyZr0Ds1Q0ZSmrnbPD2FV5k
 mtAygcBnEP3Z9R8m0dqeZ1E4W7Ot/+1wOUgfPQl8l3df6zLBp8XJo1O+dYY/dQpdEPM=
X-Gm-Gg: ASbGncsKxjCisiKGhmuKE7ClPlEl/M2b1/Vm3St/FAeB2ECXamb2oud1btyijQEYiX6
 RC7JYfuHkNV3WhwHrXHdutSc+jnZzTBQhAx/aRIH6NG2vTH7R2rCQU4gkRRTBFRJRItMafRDbRB
 Fb42ZaEhQIGMxX8tcs2CyFxxmQKgEOZwP2GM50y4ltdAsAc1QSezY4WRFw/vergel+Ekc4iPUyG
 OSYIo/oU6nUlmJso79u7xWe0I142IH0k3UoyS5CQbpUqOfcUIXIJWTWi8KKQZezMh7PByVqnjTK
 2JgFC8mgFsW5+cjj132y2q5VLHm22mdypVOuHX4DWIZquMYpZI6OYITzDup77JFZXnvf2hC0MsJ
 rDVa6pcrV3BEcn9dj8ThnwvRoaw/MNQAO0g==
X-Google-Smtp-Source: AGHT+IFugVKKICtOD9pfM7hk8BKEfOXp3bHQH3mFfTbwBJUrg0s6M6yFWSIgA+9ROJ/IRghf4QkDKw==
X-Received: by 2002:a05:6000:270e:b0:3e7:9d76:beb5 with SMTP id
 ffacd0b85a97d-3e79d76c25emr6942960f8f.14.1757960838138; 
 Mon, 15 Sep 2025 11:27:18 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e86602a7d5sm11182914f8f.62.2025.09.15.11.27.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 11:27:15 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6BBC35F867;
 Mon, 15 Sep 2025 19:27:13 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: Gustavo Romero <gustavo.romero@linaro.org>,  qemu-devel@nongnu.org,
 Daniel =?utf-8?Q?P=2EBerrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org
Subject: Re: [RFC PATCH 0/2] tests/functional: Adapt reverse_debugging to
 run w/o Avocado (yet another try)
In-Reply-To: <d735ec67-dc45-438c-9151-6ced6ff49b77@redhat.com> (Thomas Huth's
 message of "Mon, 15 Sep 2025 18:18:22 +0200")
References: <20250915124207.42053-1-thuth@redhat.com>
 <875xdjpubx.fsf@draig.linaro.org>
 <d735ec67-dc45-438c-9151-6ced6ff49b77@redhat.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Mon, 15 Sep 2025 19:27:13 +0100
Message-ID: <87tt13o9ku.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Thomas Huth <thuth@redhat.com> writes:

> On 15/09/2025 18.13, Alex Benn=C3=A9e wrote:
>> Thomas Huth <thuth@redhat.com> writes:
>>=20
>>> Here's yet another attempt to remove the avocado dependency from the
>>> reverse debugging tests: I basically took Gustavo's patches to rework
>>> tests/functional/reverse_debugging.py, but instead of calling that
>>> through tests/guest-debug/run-test.py and adding the cumbersome code
>>> to support additional test execution logic, I kept our normal way of
>>> running tests via pycotap.
>> Hmm I was getting:
>>    2025-09-15 17:10:50,798 - INFO: GDB CMD:
>> /home/alex/src/tools/binutils-gdb.git/builds/all/install/bin/gdb -q
>> -n -batch -ex 'set pagination off' -ex 'set confirm off' -ex "py
>> sys.argv=3D['/home/alex/lsrc/qemu.git/tests/functional/reverse_debugging=
.py']"
>> -x /home/alex/lsrc/qemu.git/tests/functional/reverse_debugging.py
>>    2025-09-15 17:10:50,803 - DEBUG: Using cached asset /home/alex/.cache=
/qemu/download/7e1430b81c26bdd0da025eeb8fbd77b5dc961da4364af26e771bd39f379c=
bbf7 for https://archives.fedoraproject.org/pub/archive/fedora/linux/releas=
es/29/Everything/aarch64/os/images/pxeboot/vmlinuz
>>    2025-09-15 17:10:50,891 - INFO: gdb output:
>>     Python Exception <class 'ModuleNotFoundError'>: No module named 'pyc=
otap'
>>    Error occurred in Python: No module named 'pycotap'
>
> Ah, sorry, I have it installed pycotap system-wide, too, so I did not
> notice it... I'll fix it in the next version if we decide to proceed
> with this approach instead of using one of the others.

FWIW I prefer this approach.

>
>  Thomas

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

