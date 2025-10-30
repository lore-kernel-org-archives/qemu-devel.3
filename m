Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C23CCF9F1
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 10:19:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEPjQ-0001a4-TZ; Thu, 30 Oct 2025 06:18:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEPjF-0001WF-Nq
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 06:18:03 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEPj2-0003sO-GL
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 06:17:57 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b704db3686cso192927066b.3
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 03:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761819461; x=1762424261; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ntmEVStypM9NDMxv0Zbv2tSchJPgKLUTExE5J8/D70I=;
 b=GD2HvRoTflILfmr7kkVBT6kfh7XEp+TAaCKAEtx/onQbsT0pzMMxV1kq0Vl6CUUhlA
 9NKBy2a89Pt5bDcurptDHly1bBtCJ9n/PIkhE4y4nlyVNswvuXLf1AxZWdK9anz5SDKz
 D4NyaygL5FGqKLG5t2OJedPbo8+Zk+dP3jlNKIeYf7j3/8+4gROhboNLNawUvenK8iFj
 XhM294xxhsVpjBTAv4ckWyAYNwTQIfgnHBHI6AAABxnlXGiutEWN8otNKaf8dB15nQjc
 7Q9V+jGvTFnQekHa5+cob928T+bJxTbzy7ky6AFGXrwxNff24AW/vpghBzdyfpzfTHy9
 MIMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761819461; x=1762424261;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ntmEVStypM9NDMxv0Zbv2tSchJPgKLUTExE5J8/D70I=;
 b=ME6IBOEEB4QSfXkrKP5Xb/zKUzB+8lsXmftW6O0fI4QYdXpbnBWmldGxOxyOWFOXRN
 fmjwonoqDfUbPf8F5M0QWeazo0/W56Z+IrDSImOe3WQD9wwGuEVpjPbXG/RX1Wiwz+2Q
 OIvGPaDNMdIMzhA93gu3nbzYVIaVq2Lqan33Y5/OHaC7O3vRPcpW+6UmNhZ1ncMtsUf7
 U2V9cklwDLaMAOJDrbpqqFrMYY3Rd5BxSGC2el0aQ9yphm1VzUq/k5uOT1smSy9HJv62
 53EiLk3c8dcPxGDvVRddtbmxHqJlYmvmeJJExEF2nAZphJesCJ7aM49AaqbCO6xA+9Gp
 ypuQ==
X-Gm-Message-State: AOJu0YzGrRpyPC3v5teB0BI5jaBfSloXEoclsGF1sEiE9s6Rauu2Y3Jp
 Xc22RJFiZ4FdhR7aoN6TEEJqRqUtdAmfIhxiDKz9w91fCji+BTPNGxqbH4u6OqIOIeVFjbEiGeH
 KfkhnxZc=
X-Gm-Gg: ASbGncvi/YdYV6/oRL7u4onCsEG5hRhdAx78xR+m8P/fGRkPiGkTlxXl9A7wvUcCSi1
 OrTatZAmN1KwbF11mM/F3yShZgqpBYlaI6BjHN/0K8+IQQpcGD2s4Ov2ik/9rJ1au5n2czXXKr9
 ENZsewT7bLatvx4IWHWLyIEDnmePIQarXQucdVLmMddtKVwNd4mj5TizsOcaaOScjZjbfU7r3ph
 8upOniR8I6ogdIEnqUzOXD2rJuXsBDEQxvqLdUSqq0bZGQ/D4wMbZMMrEOIOP2GkpOlVRVLtNfa
 P3Fv5MNEaV5kvZ5RpSFzRTg2dcUzQ0OOgug7gW9UxyNJlgvm4ETXmrUgkQsWqAMje63f+kGhJPi
 u6AqrKsWVrtUzsjchnQ8gBaINp0TvIGQgb45eCoDgpCog7i+ClWU1WgWngNAJMRXsiQ+DVQEqLa
 AX70ZnOf4PhUD6jBtHnorBS8PhfqCubKHLYB/udqVW/KA=
X-Google-Smtp-Source: AGHT+IEGw4Ywpux4O8bfMDSY3XVnc5ypPQCKw0vHJzyiI039l/8CxJl5jWtsdGlAsklJwyPVkDpMHw==
X-Received: by 2002:a05:6000:601:b0:427:699:a9cf with SMTP id
 ffacd0b85a97d-429aefb9ca4mr5669215f8f.33.1761818662403; 
 Thu, 30 Oct 2025 03:04:22 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952d3532sm31956528f8f.20.2025.10.30.03.04.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Oct 2025 03:04:21 -0700 (PDT)
Message-ID: <80d9f994-dda4-42dc-8214-a0134798f732@linaro.org>
Date: Thu, 30 Oct 2025 11:04:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/23] Misc single binary patches for 2025-10-29
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20251029214001.99824-1-philmd@linaro.org>
In-Reply-To: <20251029214001.99824-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 29/10/25 22:39, Philippe Mathieu-Daudé wrote:
> The following changes since commit e090e0312dc9030d94e38e3d98a88718d3561e4e:
> 
>    Merge tag 'pull-trivial-patches' of https://gitlab.com/mjt0k/qemu into staging (2025-10-29 10:44:15 +0100)
> 
> are available in the Git repository at:
> 
>    https://github.com/philmd/qemu.git tags/single-binary-20251029
> 
> for you to fetch changes up to e5c542fa16b0a7d47070692481db301736a0ac7b:
> 
>    hw/riscv: Replace target_ulong uses (2025-10-29 19:16:24 +0100)
> 
> ----------------------------------------------------------------
> Various patches related to single binary work:
> 
> - Make hw/arm/ common by adding a QOM type to machines to
>    tag in which binary (32 or 64-bit) they can be used.
>    Convert the Virt and SBSA-Ref machines.
> - Build Xen files once
> 
> ----------------------------------------------------------------

I'm seeing a failure on mainstream pipeline:

https://gitlab.com/qemu-project/qemu/-/jobs/11906335084
▶  5/68 test_bpim2u.BananaPiMachine.test_arm_bpim2u 
                FAIL
▶  5/68 test_bpim2u.BananaPiMachine.test_arm_bpim2u_gmac 
                FAIL
▶  5/68 test_bpim2u.BananaPiMachine.test_arm_bpim2u_initrd 
                FAIL

which I failed to notice locally in part because Darwin LLVM 'ar'
doesn't not work like the GNU equivalent:

$ pyvenv/bin/meson test --print-errorlogs --setup thorough func-arm-bpim2u
ninja: Entering directory `/build'
[1301/1301] Generating qemu-system-arm with a custom command
▶ 1/1 test_bpim2u.BananaPiMachine.test_arm_bpim2u 
   FAIL
▶ 1/1 test_bpim2u.BananaPiMachine.test_arm_bpim2u_gmac 
   FAIL
▶ 1/1 test_bpim2u.BananaPiMachine.test_arm_bpim2u_initrd 
   FAIL
1/1 qemu:func-thorough+func-arm-thorough+thorough / func-arm-bpim2u 
   ERROR            1.24s   exit status 1
―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― 
✀ 
――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
stderr:
Traceback (most recent call last):
   File "/src/qemu/tests/functional/arm/test_bpim2u.py", line 41, in 
test_arm_bpim2u
     kernel_path = self.archive_extract(
         self.ASSET_DEB, member='boot/vmlinuz-6.6.16-current-sunxi')
   File "/src/qemu/tests/functional/qemu_test/testcase.py", line 83, in 
archive_extract
     archive_extract(archive, self.scratch_file(), format, member)
     ~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   File "/src/qemu/tests/functional/qemu_test/archive.py", line 92, in 
archive_extract
     deb_extract(archive, dest_dir, "./" + member)
     ~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   File "/src/qemu/tests/functional/qemu_test/archive.py", line 57, in 
deb_extract
     check_call(['ar', 'x', archive, file_path],
     ~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                stdout=DEVNULL, stderr=DEVNULL)
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   File 
"/opt/homebrew/Cellar/python@3.13/3.13.7/Frameworks/Python.framework/Versions/3.13/lib/python3.13/subprocess.py", 
line 419, in check_call
     raise CalledProcessError(retcode, cmd)
subprocess.CalledProcessError: Command '['ar', 'x', 
'~/.cache/qemu/download/3d968c15b121ede871dce49d13ee7644d6f74b6b121b84c9a40f51b0c80d6d22', 
'data.tar.xz/']' returned non-zero exit status 1.

Traceback (most recent call last):
   File "/src/qemu/tests/functional/arm/test_bpim2u.py", line 98, in 
test_arm_bpim2u_gmac
     kernel_path = self.archive_extract(
         self.ASSET_DEB, member='boot/vmlinuz-6.6.16-current-sunxi')
   File "/src/qemu/tests/functional/qemu_test/testcase.py", line 83, in 
archive_extract
     archive_extract(archive, self.scratch_file(), format, member)
     ~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   File "/src/qemu/tests/functional/qemu_test/archive.py", line 92, in 
archive_extract
     deb_extract(archive, dest_dir, "./" + member)
     ~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   File "/src/qemu/tests/functional/qemu_test/archive.py", line 57, in 
deb_extract
     check_call(['ar', 'x', archive, file_path],
     ~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                stdout=DEVNULL, stderr=DEVNULL)
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   File 
"/opt/homebrew/Cellar/python@3.13/3.13.7/Frameworks/Python.framework/Versions/3.13/lib/python3.13/subprocess.py", 
line 419, in check_call
     raise CalledProcessError(retcode, cmd)
subprocess.CalledProcessError: Command '['ar', 'x', 
'~/.cache/qemu/download/3d968c15b121ede871dce49d13ee7644d6f74b6b121b84c9a40f51b0c80d6d22', 
'data.tar.xz/']' returned non-zero exit status 1.

Traceback (most recent call last):
   File "/src/qemu/tests/functional/arm/test_bpim2u.py", line 62, in 
test_arm_bpim2u_initrd
     kernel_path = self.archive_extract(
         self.ASSET_DEB, member='boot/vmlinuz-6.6.16-current-sunxi')
   File "/src/qemu/tests/functional/qemu_test/testcase.py", line 83, in 
archive_extract
     archive_extract(archive, self.scratch_file(), format, member)
     ~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   File "/src/qemu/tests/functional/qemu_test/archive.py", line 92, in 
archive_extract
     deb_extract(archive, dest_dir, "./" + member)
     ~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   File "/src/qemu/tests/functional/qemu_test/archive.py", line 57, in 
deb_extract
     check_call(['ar', 'x', archive, file_path],
     ~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                stdout=DEVNULL, stderr=DEVNULL)
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   File 
"/opt/homebrew/Cellar/python@3.13/3.13.7/Frameworks/Python.framework/Versions/3.13/lib/python3.13/subprocess.py", 
line 419, in check_call
     raise CalledProcessError(retcode, cmd)
subprocess.CalledProcessError: Command '['ar', 'x', 
'~/.cache/qemu/download/3d968c15b121ede871dce49d13ee7644d6f74b6b121b84c9a40f51b0c80d6d22', 
'data.tar.xz/']' returned non-zero exit status 1.



