Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12450CD4851
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 14:47:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNXKq-0003Ny-52; Thu, 14 May 2026 10:46:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNXKl-0003Nl-TH
 for qemu-devel@nongnu.org; Thu, 14 May 2026 10:46:44 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNXKj-0006ph-Sw
 for qemu-devel@nongnu.org; Thu, 14 May 2026 10:46:43 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-48d146705b4so95651575e9.3
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 07:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778769998; x=1779374798; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=g6p/ntp7SbLGjFviv2KJddKCvrl1Pvuo+JgY1fActe0=;
 b=JCIS+uQVaA4oiU9ar7Ibvu8PAqoQahy2BYkZu7WDS+h075MJO2Lfqc7vl6QAhhfW2m
 a0SgQA256yp5mM+Kj7O55P8ZUfg8ZT1zbcoXeJpnoPsKnmQjmvw6yWYZ6WNTBMombIyf
 GyyjysyWj8/lbE/6aZ0qFQM5wGNfkykZHLWLHvZmK1JMCnUCM9XryDaG8BBXXGDp71Pm
 XR/bJKsU21H+AS06+PdRQ5F8cgUL0rKMbLev9itc0izrpdXhik2DuL/BuDWwafwbiqlC
 AOu0AZPK8OyZk5guN+JzVZxS+ijSwEJbQGnzechKWmtlgk/oXQGPNYjW/ii79IuYa0Kr
 S0ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778769998; x=1779374798;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g6p/ntp7SbLGjFviv2KJddKCvrl1Pvuo+JgY1fActe0=;
 b=k8uf9gOwMKRHIdmUSEr17XjJVRAvIAd58jUk+OMf2eNnmdtqUDc5cb8acHnE8rqfam
 kcPn6FAojXtaI4vcfo7DcixsWPOaHwRBFMNSWLQeiw5B+7pi1I6AQysBC6uOt+ub+g49
 tuJPeD2wZp6+NV7H7KIOrmvFeZBL6u0IPA74/gsxSDHr5Emmscei+W+i2Nvf8D1MI43z
 LBVxle8PtwgcwReiTcKGmDiy5Uq7a7l+WwVhOyAwoLZXsWpAFl/I6FIu7SdrqqPa2Ruh
 qgNajGXvN2WqNWZ4L8C4pQdUPDuDuTmO8Zkh61D8x5bC4JdPWHevX2WlSYhYHW88LSy3
 /Cvg==
X-Gm-Message-State: AOJu0YwD9fMQiETos8OsYfS4bOViBUcVd9pUjjk0mQrukTq1CEAjRJrz
 ABK4NZbXuVZrFxDiqkqEW3LXwBmdbY406WcpRhwsD1VWx1tQyPqPy4gV0ryQzGR2loY=
X-Gm-Gg: Acq92OFK08gHQ745nKh5o/uWTHcTEmg7Efjp4CqR9dK5zzs7jturl0lg9UJnSXW0EP2
 f6kflN1Zg3Gjq7NEFvH1Iu4UhBN0GuDonaw1+EtHet81nP1Iz7x3czKrOrI/kkCHQlKNlEIIh9v
 +jZOLJMpsk4OUX9FvCY909kak6eF0atKkHDLgwAfWtPq4CH2bVzbRUvMtZ1tbFaqmXbWN++9gig
 +3yUC83FKT2BFw+lppbnpvFs5oYTGsUHu3/Z0nFV0W7hYRJeBeJ8DwKgS6N9PBV7pJVr5HvxITD
 pqq4gvwBqD94o5MNdu0oqLaqNzFn0ciVO0yn7Wz2E4+yk/4TTvsTbrqnhmtrVnPfNdSROqFlHCV
 f49stFtDxcBc9o9Oz/o937To9PQXQuetPLabSNcYl+iV7khdE+Wm0xZtJJnkZ1tvzWD85pbU3rW
 YF8Rbzb66ppG9VjtW2e7mPNS5WkQZhpYojNIVep0ZTL5/Husuk0PBvnlmQoZjpo9Eh1ne6yG6Mt
 uMQ
X-Received: by 2002:a05:600c:4c29:b0:48f:d1b8:9ab1 with SMTP id
 5b1f17b1804b1-48fd1b8a1ecmr60023765e9.9.1778769998390; 
 Thu, 14 May 2026 07:46:38 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe4600a14sm3590215e9.0.2026.05.14.07.46.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 May 2026 07:46:37 -0700 (PDT)
Message-ID: <953abafd-3dbd-4055-a500-d089ace35470@linaro.org>
Date: Thu, 14 May 2026 16:46:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/5] Target-info update for 2026-05-12
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
References: <20260512183030.1431103-1-pierrick.bouvier@oss.qualcomm.com>
 <CAJSP0QXjoF0qPpNq==p1fqTHMWQdezzQLHKKwm6iUBXHdPr-fg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAJSP0QXjoF0qPpNq==p1fqTHMWQdezzQLHKKwm6iUBXHdPr-fg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 14/5/26 16:16, Stefan Hajnoczi wrote:
> On Tue, May 12, 2026 at 2:32 PM Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>
>> The following changes since commit 5e61afe211e82a9af15a8794a0bd29bb574e953b:
>>
>>    Merge tag 'ui-pull-request' of https://gitlab.com/marcandre.lureau/qemu into staging (2026-05-11 10:49:53 -0400)
>>
>> are available in the Git repository at:
>>
>>    https://gitlab.com/p-b-o/qemu tags/pbouvier/pr/target_info-20260512
>>
>> for you to fetch changes up to 0fc2022c6331c5d5bdd9060c73d067abba3f5515:
>>
>>    target-info: replace target_info() in system-mode (2026-05-12 11:29:18 -0700)
>>
>> ----------------------------------------------------------------
>> Changes:
>> - [PATCH v6 0/5] single-binary: deduplicate target_info() (Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>)
>>    Link: https://lore.kernel.org/qemu-devel/20260512150208.1167711-1-pierrick.bouvier@oss.qualcomm.com
>>
>> ----------------------------------------------------------------
>> Pierrick Bouvier (5):
>>        qom/object: register OBJECT and INTERFACE QOM types before main
>>        qom/object: initialize type_table in static ctor with fundamental QOM types
>>        target-info: introduce TargetInfo in QOM
>>        target-info-qom: detect target from QOM
>>        target-info: replace target_info() in system-mode
> 
> Please take a look at this CI failure:
> 
> Testing ./build-oss-fuzz/DEST_DIR/qemu-fuzz-i386-target-generic-fuzz-cirrus-vga
> ...
> AddressSanitizer:DEADLYSIGNAL
> =================================================================
> ==5334==ERROR: AddressSanitizer: SEGV on unknown address
> 0x000000000020 (pc 0x5bd0beb39ef4 bp 0x7ffe0ad764d0 sp 0x7ffe0ad764c0
> T0)
> ==5334==The signal is caused by a READ memory access.
> ==5334==Hint: address points to the zero page.
> #0 0x5bd0beb39ef4 in target_endian_mode
> /builds/qemu-project/qemu/build-oss-fuzz/../target-info.c:42:27
> #1 0x5bd0beb39ef4 in target_big_endian
> /builds/qemu-project/qemu/build-oss-fuzz/../target-info.c:47:12
> #2 0x5bd0bf4f1da1 in qtest_process_command
> /builds/qemu-project/qemu/build-oss-fuzz/../system/qtest.c:705:13
> #3 0x5bd0bf4f1da1 in qtest_process_inbuf
> /builds/qemu-project/qemu/build-oss-fuzz/../system/qtest.c:778:9
> #4 0x5bd0bf4eef54 in qtest_server_inproc_recv
> /builds/qemu-project/qemu/build-oss-fuzz/../system/qtest.c:910:9
> #5 0x5bd0bfe18f85 in qtest_sendf
> /builds/qemu-project/qemu/build-oss-fuzz/../tests/qtest/libqtest.c:715:5
> #6 0x5bd0bfe15294 in qtest_query_target_endianness
> /builds/qemu-project/qemu/build-oss-fuzz/../tests/qtest/libqtest.c:804:5
> #7 0x5bd0bfe1f2f3 in qtest_inproc_init
> /builds/qemu-project/qemu/build-oss-fuzz/../tests/qtest/libqtest.c:2043:23
> #8 0x5bd0bfe71778 in qtest_setup
> /builds/qemu-project/qemu/build-oss-fuzz/../tests/qtest/fuzz/fuzz.c:64:12
> #9 0x5bd0bfe71778 in LLVMFuzzerInitialize
> /builds/qemu-project/qemu/build-oss-fuzz/../tests/qtest/fuzz/fuzz.c:206:16
> #10 0x5bd0be9b3b56 in fuzzer::FuzzerDriver(int*, char***, int
> (*)(unsigned char const*, unsigned long)) fuzzer.o
> #11 0x5bd0be9e2166 in main


IIUC the fuzzer mode doesn't call main() -> qemu_init() but a distinct
one via LLVMFuzzerInitialize().

We'd need to squash something like:

-- >8 --
diff --git a/tests/qtest/fuzz/fuzz.c b/tests/qtest/fuzz/fuzz.c
index ca248a51a6c..90f07dcda3d 100644
--- a/tests/qtest/fuzz/fuzz.c
+++ b/tests/qtest/fuzz/fuzz.c
@@ -172,6 +172,7 @@ int LLVMFuzzerInitialize(int *argc, char ***argv, 
char ***envp)
      /* Initialize qgraph and modules */
      qos_graph_init();
      module_call_init(MODULE_INIT_FUZZ_TARGET);
+    module_call_init(MODULE_INIT_TARGET_INFO);
      module_call_init(MODULE_INIT_QOM);
      module_call_init(MODULE_INIT_LIBQOS);

---

> (/builds/qemu-project/qemu/build-oss-fuzz/DEST_DIR/qemu-fuzz-i386-target-generic-fuzz-cirrus-vga+0x46166)
> (BuildId: 845b9265a3ae1439c62fb86e3bc4973f7ea7c960)
> #12 0x7f7fef9a65b4 in __libc_start_call_main (/lib64/libc.so.6+0x35b4)
> (BuildId: abd2a4d896fed122b3f7da571746f193feeb86a1)
> #13 0x7f7fef9a6667 in __libc_start_main@GLIBC_2.2.5
> (/lib64/libc.so.6+0x3667) (BuildId:
> abd2a4d896fed122b3f7da571746f193feeb86a1)
> #14 0x5bd0be9a8f34 in _start
> (/builds/qemu-project/qemu/build-oss-fuzz/DEST_DIR/qemu-fuzz-i386-target-generic-fuzz-cirrus-vga+0xcf34)
> (BuildId: 845b9265a3ae1439c62fb86e3bc4973f7ea7c960)
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/14371480130
> 
> If this issue is caused by this pull request, please send a new
> revision that solves the issue.
> 
> If this issue is not caused by this pull request, please let me know. Thanks!
> 
> Stefan
> 
>>
>>   configs/targets/aarch64-softmmu.c |  6 ++---
>>   configs/targets/arm-softmmu.c     |  6 ++---
>>   include/qemu/module.h             |  1 +
>>   include/qemu/target-info-init.h   | 53 +++++++++++++++++++++++++++++++++++++++
>>   include/qemu/target-info-qom.h    | 30 ++++++++++++++++++++++
>>   qom/object.c                      | 22 +++++-----------
>>   system/vl.c                       |  4 +++
>>   target-info-qom.c                 | 45 +++++++++++++++++++++++++++++++++
>>   target-info-stub.c                |  6 ++---
>>   9 files changed, 145 insertions(+), 28 deletions(-)
>>   create mode 100644 include/qemu/target-info-init.h
>>   create mode 100644 include/qemu/target-info-qom.h
>>
> 


