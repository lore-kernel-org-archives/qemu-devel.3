Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B2B9C7EE31
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 16:38:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUpbU-0002tH-Rv; Thu, 26 Jun 2025 12:37:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uUpbT-0002t7-FB
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 12:37:35 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uUpbR-0001G4-4X
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 12:37:35 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-451d54214adso8670285e9.3
 for <qemu-devel@nongnu.org>; Thu, 26 Jun 2025 09:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750955849; x=1751560649; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sYYWto7eRTjBwTGBrT/RpjPpZf99XCQPbMe+pvgjw00=;
 b=ODrNS9sKYCJlRD9LHS3PNj/8jUgQ35oG9clK60gqFuOGnNyHxEX307Kf3dEivXSpab
 unAzHqvnoTiGgLMc2h/2bZHrAc/npNH1kDiG6fRAPNLP8BdGCZ4ibHyJ6Y5/FwFvyTb/
 vS9dMBiTJP6EoSgqmmTP02M73BAErxVItCjXNQ4bW4nnZIw4j8BBj7RKs+zZj/9zaA+O
 KVJAEvfW0DTBJIZ7mrh39k92Q+I4UD2+j+BnolBQ9reuhUNPPzk9pACghLAlH5UANfPS
 /TpTBvKDbS6D09FbfPkyJ5u7kB8LQwnLbPqMmOzVWxnkfqZnAc80LOdszGfbnVLdYH2g
 gjYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750955849; x=1751560649;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sYYWto7eRTjBwTGBrT/RpjPpZf99XCQPbMe+pvgjw00=;
 b=xPlOo1kHVAFdQZU8u6PmBu0RDMmzNvYj/1gJZqBKjdW5eFVq/FPDeRWtz/ssOREwY6
 bfnMkMQqBkMDYZLf1c0u0KbdYCdqdcbx+WlwAOS28KgaBue0aM4WFUFrcAPozcN5G1LP
 hsdaPfmGd7RMQqPEzJLPXIpeORScb734ltRMRNDA3w6o8npi6eI+1exn39ktF+0MZIfn
 HaBrrzUjSV+YfqHrnOk4ZSviF/+XGlqixu+uxEmTfKwlzI696fhhJoFHGziSoGSg8dY3
 dV1llUk24lnlelhD+mcDimqK7fQ4iesNzCX8rBRd4A8FmpS161w9EX9lPDOa6nqmpmi0
 C1dQ==
X-Gm-Message-State: AOJu0YwqSXypwdVaJtoXYtAqGYtRpO/nsEVdNipHEbNEiU3ydIPOkhth
 Bl8c2lc1EoFtngsJ4mrENWy7NG/+zPHjNOrw1XoDxRMXMWBLHwKwtlmgU/t6ndV657c=
X-Gm-Gg: ASbGncuwM6/Gq+BfUyl2lQ+Qctz6zkJgKMtBAsxG87lNPhHwvrxoGywKmqkxiUVBAol
 mACLww8C9fMrNFh6sbCydaghy5442sIExWE+Xa4//nIqs/+jaCio1Hrc2Y55zoKbAtUKlufCkUC
 0xpa8ukt9fMl1UTdp5DDFkIrcFUYY2eLV2QKyDqdxNxQ8HxfU/K1v3rR5VxZzA/NvPDZFUjzH2k
 6rOYhtwo6AHCNu8mgCmhFkU5gQtWtSx7UWfT3IH56VMU0xgS86xEZAMNGLCUyB4Hy9ooUpiGGN7
 sEypuzQkK7Podgh6x3iN2xDQnumEsxZgrCms3CMp5n1RVtoWUbLyQFjjiZPwa4I=
X-Google-Smtp-Source: AGHT+IEK8sFabI1UwufYaJkgbCPMf1Jayk9XnO9avenWIB8d7XRrv6N8Upgrj7vhyQBZ4KwAvf92hA==
X-Received: by 2002:a05:6000:2082:b0:3a3:7ba5:93a5 with SMTP id
 ffacd0b85a97d-3a8feb85191mr230989f8f.26.1750955848885; 
 Thu, 26 Jun 2025 09:37:28 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453814ae64fsm38429945e9.1.2025.06.26.09.37.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Jun 2025 09:37:27 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9A5ED5F847;
 Thu, 26 Jun 2025 17:37:26 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Rowan Hart <rowanbhart@gmail.com>
Cc: qemu-devel@nongnu.org,  Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,  Mahmoud Mandour
 <ma.mandourr@gmail.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>,  Yanan Wang
 <wangyanan55@huawei.com>,  Alexandre Iooss <erdnaxe@crans.org>,  Eduardo
 Habkost <eduardo@habkost.net>,  Zhao Liu <zhao1.liu@intel.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v14 0/8] Add additional plugin API functions to read and
 write memory and registers
In-Reply-To: <87o6ubzxfw.fsf@draig.linaro.org> ("Alex =?utf-8?Q?Benn=C3=A9?=
 =?utf-8?Q?e=22's?= message of "Wed, 25 Jun 2025 15:51:31 +0100")
References: <20250624175351.440780-1-rowanbhart@gmail.com>
 <87o6ubzxfw.fsf@draig.linaro.org>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Thu, 26 Jun 2025 17:37:26 +0100
Message-ID: <87cyaqzcft.fsf@draig.linaro.org>
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

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Rowan Hart <rowanbhart@gmail.com> writes:
>
>> This patch series adds several new API functions focused on enabling use
>> cases around reading and writing guest memory from QEMU plugins. To supp=
ort
>> these new APIs, some utility functionality around retrieving information=
 about
>> address spaces is added as well.
>
> Queued to plugins/next, thanks.

So this fails a number of the CI tests, mostly due to 32 bit issues:

  https://gitlab.com/stsquad/qemu/-/pipelines/1890883927/failures

The tci failure is easy enough:

--8<---------------cut here---------------start------------->8---
modified   tests/tcg/x86_64/Makefile.softmmu-target
@@ -34,9 +34,11 @@ memory: CFLAGS+=3D-DCHECK_UNALIGNED=3D1
 # Running
 QEMU_OPTS+=3D-device isa-debugcon,chardev=3Doutput -device isa-debug-exit,=
iobase=3D0xf4,iosize=3D0x4 -kernel
=20
+ifeq ($(CONFIG_PLUGIN),y)
 run-plugin-patch-target-with-libpatch.so:		\
 	PLUGIN_ARGS=3D$(COMMA)target=3Dffc0$(COMMA)patch=3D9090$(COMMA)use_hwaddr=
=3Dtrue
 run-plugin-patch-target-with-libpatch.so:		\
 	CHECK_PLUGIN_OUTPUT_COMMAND=3D$(X64_SYSTEM_SRC)/validate-patch.py $@.out
 run-plugin-patch-target-with-libpatch.so: patch-target libpatch.so
 EXTRA_RUNS+=3Drun-plugin-patch-target-with-libpatch.so
+endif
--8<---------------cut here---------------end--------------->8---

The other problem is trying to stuff a uint64_t into a void * on 32 bit.
We did disable plugins for 32 bit but then reverted because we were able
to fixup the cases:

 cf2a78cbbb (deprecation: don't enable TCG plugins by default on 32 bit hos=
ts)
 db7a06ade1 (configure: reenable plugins by default for 32-bit hosts)

So I don't what is easier:

 - re-deprecate for 32 bit systems
 - only build libpatch on 64 bit systems
 - fix libpatch to handle being built on 32 bit systems

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

