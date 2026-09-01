Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C60C624C6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 09:14:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1KW3-0005cY-4o; Tue, 01 Sep 2026 05:10:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1KVw-0005Zd-6v
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 05:10:44 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x1KVu-0000wY-Hm
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 05:10:43 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-7dbcb505578so6643757b3.3
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 02:10:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788253840; cv=none;
 d=google.com; s=arc-20260327;
 b=TbEeDpkHv2/txys50FHoa21LnFpY72gOhT4l32sOcBPv/5RsGV2muihKsNNSTKDjlf
 zCfg6k58obOntqpNEWzK6JvQ43qZkAD0j4C+ichSJcMgHL6cqAbPUryk+wsQ+OPSYHWh
 OthIuEy5S8jneZq+GIbWg26rt3mQETbeYfoBu0MKImExPJ/fVV+GYoCyV7iQIy8Nhp6+
 Y0Rgdwmy7Gx6e8KEF/2XrjqTL6wr0oZl4G/YoZ2M+V36Xu9UGfYImQ63tR5kPQROKtUw
 rPESEtzRf5wIe3jz6Y3th+i5glOwbq6g+SW4pEHR5jgfcFsYtuJmEaAq2+gx9xpcBMpl
 WUag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3WzOwyt7a7csW3ocu/4CfiRMCfvVaHZh6P4t2PKZj7w=;
 fh=a48Yz94NrSN1VfxXFKxdHg5tRcnTkBUqJPewYKl8hN0=;
 b=fUIDZzC8eeHob85Qg4aVvumAWj20/TTGVtsV8CLGDzzNfcQq+RQVRWPQizUy+ibA1f
 Lj2VMO5TC7LFHBDIzvwBBGg7Qs8UR5xNrOnIBUgQXHEE2bWWb8SU9xFwAxqZ0DOpiRp7
 YjIvft1LMn6h4RE1sFXajtln/aESfdJPeyalFapPGYO4E4OpivcmyTxbKgPhedGphDvP
 czpcRlb4/zzZklZhsT1cg7hVQYRHj0Nbio9RiJrhpD2/fVRwrWKEckR6uoKQTXs7p+SZ
 3n4ADoiShui3mSm1pP50BrwB5g0Mk2vuregzR7TgRqwSKOqImVvRKVnHrKhATVU3w3H3
 42bQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788253840; x=1788858640; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3WzOwyt7a7csW3ocu/4CfiRMCfvVaHZh6P4t2PKZj7w=;
 b=RgAaf4xqcs2EMqiSOFXmJmxMpPobGMsnMH6pALxuLGiSGuzyUHxJN6IqOJ8Lkp18pK
 ItjiGCGO42DKxWjDQjP0z03ONEE7lrXmVsZF3+Jk11LeW7kocQ/XdVrUWwKBUIGvRZCy
 X4+1c2JHsh7efF1JBSpQ/WxQJy4muylfksyZMEeHSGdWgrQUkt5Vl0eJ7kzb2p33u/80
 PZIRN3RiAQ9kSbX9uwkl8NOU/TBAtOPS8a9cUiMihJRMt9344BrMJKjuRBAPprVvjlUV
 krRgCw8NrZROWeZPd6OaTkQhKdQv/qTzfd9CTeksaphbR6qb5ShopbedoL+FVThffJ6u
 qYxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788253840; x=1788858640;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3WzOwyt7a7csW3ocu/4CfiRMCfvVaHZh6P4t2PKZj7w=;
 b=b7Hcm7TnNeVPoAQXUY7oTu+4kSU35PtMZHwdnf2g0KIaQath0Vtz5O/kntjiVP3vBI
 oI89QKAbNerXMrVcmtgtY2kHlXylj9hV7QgNEHqQOhJNxw0w9cjibIUtdNE6/ba74Clc
 orvEDBqVbi1LWMndkGUcAEaUCuG3E087OEATKvHXLrNfYpcJRjbtrbP8EWiGwKJphCiF
 no0GgRRXqhlQTD4RQQSV0tKayogGCQwn3ds8QkszRyMs5CWyEesqeptPOCvsy1Tbzcaw
 tH0QuK9Jdzyn2c99SMJ7AJZgeMlKZPhzTpQdfBj3+ZEFjT5I0QAOrron8V7sEKGY0HgE
 qxqQ==
X-Gm-Message-State: AFuF++moBoD3yWb2l270j/WaZYRJ7VeA5IwBD3v/VSIVoen+Fl6/w0Re
 b8HfyCRcjGnULtTMzcVoUQSTMMshE35upUwfBLdcDJPonLvSQ36Eti6X+mUAIm2AvUMw+vbQsli
 Mo1ApRGh0eZVaNHem5kM0+vlT6rc9ap6KzdyqH+DhrQ==
X-Gm-Gg: AYBFou1raRg6ac4qUZQGkgfXcjtJNYztHkYMPpW8lVxIl9FH/FYTuEhh0C5HCUgzYTC
 eZUElSD+ugnKMJLpy047Xe9TBRtOHxLZLbF/TJzns3pU4IpHAPpUGRSy0lwlxkH9UMC5yf+nd4k
 PQl9IDtXpyBlL9fD9RpNegXIlE55Zg57iF9sLjoOyGPA2wQFcwlAElMUdhB0Gz2DTZcTFWa1v/V
 YUIJbKHq+zi6mv5r14ykLH89Cctjr9a/t13/TzG89ocsqBCOgnI6ML4KNbmhs1fwNb7lboIJX3j
 U/4yZfFXvbKqQceNuYwRgfc/fEbNcpzta4myxsXydPJisGmq1rlHiMRxg1ZYtr2LS8ZrcO0qWT6
 6gaIexabEdnhW335ui2AZ8z949HoB
X-Received: by 2002:a05:690c:e3c9:b0:85a:dd2d:9060 with SMTP id
 00721157ae682-85d6a7c4fddmr120434917b3.15.1788253839685; Tue, 01 Sep 2026
 02:10:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
 <20260829-nohmp-v2-0-c5bf7b766fe7@redhat.com>
In-Reply-To: <20260829-nohmp-v2-0-c5bf7b766fe7@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 Sep 2026 10:10:27 +0100
X-Gm-Features: AcwNN1VNvFs222ECeFnP_OMxPJVQpgXaMGyNaPXI_6CE84jcXyVODc5HuuwJbxY
Message-ID: <CAFEAcA95yjf_qr8hkPvdxj+kpF9KuU7UHkDMLWfOvfa3WqhmTQ@mail.gmail.com>
Subject: Re: [GIT PULL v2 00/50] Make HMP optional
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Sat, 29 Aug 2026 at 10:15, <marcandre.lureau@redhat.com> wrote:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> The following changes since commit d2e570cc0f97b936902a5b1b86b73c0f5998b4=
75:
>
>   Merge tag 'pull-ppc-for-11.2-20260828' of https://gitlab.com/harshpb/qe=
mu into staging (2026-08-28 15:17:04 -0700)
>
> are available in the Git repository at:
>
>   https://gitlab.com/marcandre.lureau/qemu.git tags/nohmp-pr-v2
>
> for you to fetch changes up to 7ef933e532a5f86778a16f5b0074f1c2d7b87459:
>
>   gitlab: --disable-hmp in build-without-defaults (2026-08-29 12:08:21 +0=
400)
>
> ----------------------------------------------------------------
> Make HMP optional
> v2:
>  - rebased, skip one new test
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>

This still fails "make check" on a local "--without-hmp" build:

 118/1082 qtest+qtest-i386+slow - qemu:qtest-i386/ahci-test
                ERROR            4.86s   killed by signal 6 SIGABRT
 119/1082 qtest+qtest-x86_64+slow - qemu:qtest-x86_64/ahci-test
                ERROR            5.58s   killed by signal 6 SIGABRT

Assertion failure is
 ERROR:../../tests/qtest/libqtest.c:998:qtest_vhmp: assertion failed: (ret)

"make check-functional" also fails:

 23/361 func-thorough+func-s390x-thorough+thorough -
qemu:func-s390x-ccw_virtio               FAIL             22.99s
exit status 1
292/361 func-thorough+func-m68k-thorough+thorough -
qemu:func-m68k-nextcube                   FAIL              0.17s
exit status 1
311/361 func-thorough+func-ppc-thorough+thorough - qemu:func-ppc-ppe42
                       FAIL              0.20s   exit status 1
359/361 func-thorough+func-x86_64-thorough+thorough -
qemu:func-x86_64-nvme_migration         FAIL             34.99s   exit
status 1

The first three all fail because the test does
 self.vm.cmd('human-monitor-command', command_line=3D'something')
and this throws an exception. I think the nvme one is unrelated
and is probably some existing intermittent failure.

This suggests we need to add coverage of this config to CI.

thanks
-- PMM

