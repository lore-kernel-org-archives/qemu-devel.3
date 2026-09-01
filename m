Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88487C624CF
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 10:18:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1LZe-00068f-7t; Tue, 01 Sep 2026 06:18:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1x1LZa-00068S-VP
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 06:18:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1x1LZV-00026O-VM
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 06:18:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788257908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u6JibZk/LRfSLY90JQuNUdyRUvj3e/CvgJA4LqW5DBE=;
 b=KtGp27H5WLbrJ/kIP/0O7yj3zpnnikZTu6AjxMSu61dj/TflsNb5cVleja1NmjgkXbONMS
 16qBeaYPTr9x9ZuiE1NTdIerZU6LKEkm19YtVjRDXJ9dlErQ8NwvLUSEGwJhW2wKrWdb7H
 lfEvB+PsBoAAzI+c0cv6ZLQz/S43lxU=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-xDpM0xVqNruTmecrhAiCgA-1; Tue, 01 Sept 2026 06:18:26 -0400
X-MC-Unique: xDpM0xVqNruTmecrhAiCgA-1
X-Mimecast-MFC-AGG-ID: xDpM0xVqNruTmecrhAiCgA_1788257906
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cbb20f82a0eso3760291a12.0
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 03:18:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788257906; cv=none;
 d=google.com; s=arc-20260327;
 b=ncITBsjKr65uzER5ohFdKHpvEhaEiqvVE1BKkcJQdfehRee66Nsk+fZY4MXQnxpdRe
 RwrYA/6ZcnNf059FscFxCzDa/qsZSEpJEYh5j4e8DDwaakcSoWaS/16+g81RzRbDdSoe
 0PoRkCdMcSHPfw/a3LexHv9KSKsxBH7G3tDwEnNkVdtBPMa/F0ngLWZ7gAV3jAMPGDzP
 lLUWzdEK3ZpWp4mNGVQzjj7xLWzPeKpH9b5kqH9hwiVEfHHMOXwMLRf61XMpGdu0YoXa
 sEyOJLU2sinsRiq0kXI8nt9SfuJwo8FSytPfoeAZ8uOJJRCCLm34258EpLWODPKRJtxq
 v/8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=u6JibZk/LRfSLY90JQuNUdyRUvj3e/CvgJA4LqW5DBE=;
 fh=DkcsS+wDAht8mg8Un44vEXzEP9PftsclVxpMktWLF+E=;
 b=aez701bhgMNLzYhpaVpcc5HQnVBtzFOzNLpB5L6gaimMyxJOpKJ1BGInO3o2vqBc9f
 uVqI5hbs40Rt6zMPvdj1LVeYt+av3VWaJBm4EK6kMBNS2NCrY7tKXZ2um9lYWkphyiLz
 B+QVL/pNS81AbKvPeUsgRKnajlfjPypxOOOAq5Qxq2JfBUeP3MRovPTLs+Yw36kEAAfo
 jNW/ScDhwYqb3R3Uh7dny7TFrI5H1G6+I8N0z7M+KT/kNihNKlVGNlvdTkBodFGzOxG/
 kpoZUOoHk3jzP+wFguvqVV2Q90SnVVf7O92WRWFI4izNHCPncvd7xzCeuctaNlDRAAcB
 MjyA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788257906; x=1788862706; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=u6JibZk/LRfSLY90JQuNUdyRUvj3e/CvgJA4LqW5DBE=;
 b=FNcB8EpqVr0maOBMQsszDgd+gVmsgDRbcHs94xuYjAoNeyNiN1wxmWwrBW2f6LiGpY
 B5DHYHA07o8NOLdE1AE1NGO4/R7zq9hhq1SG9UVetUlqVhnp3ptn5/HtzJRP0uQ9mt7i
 zdFKB75pWzzk02Ska4SNReMDG6ae2cV4oOJa9NBdTbY2mnfkpsoe8TrgS++6YYE6yVhx
 VQt+OcQ2tvgnrPrIXn88ICRCWMUiPi9TYyzpYpMB0tkrIY4DBBVV29n4nnCLJyHYqZbE
 8Qdf2VRmAv/hAdw+9iLGL0ADf9j2JvR0fuBkH98UwIqJyrHjuWL4OmuBpqhLiwGStavR
 U/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788257906; x=1788862706;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=u6JibZk/LRfSLY90JQuNUdyRUvj3e/CvgJA4LqW5DBE=;
 b=rqSeZSIlmnvQLFCHVFV2qeZxhCPfgJGkD6Cdw9r1XWV/8gKQkzExqhJfX9AMkfm9HJ
 CcyIibujxfRi/DRSEZEQg9FdlM5BvTBGYK3hXJOndtEcxcTcT0iMUEil+RcFRHYXdWBa
 D/snxwuWxNKTDTWnsSxLAWW66Z4DcVLyiQbOBNQfucL1r40kIy78AUKGvyN9sPdw4JRN
 zmEzaeoDlG1YzKVl7umg2X6Fc47XYj6OLidoJtAPnhbj9YpMbk73qj8xjvy+Hnz9sPzI
 mvZ4eaOVOlmuSXurublLm2NKoQbS78HRagCrSMgZ0KWn5gTziBq2F58b9BFwwNMi3Nnc
 2bUw==
X-Gm-Message-State: AFuF++nK8Jht8l/VlmaYjttSQwt8wRSrW3Z+MS8DFNYXUuwyDGGghfe5
 3HQGG9iGkc8KeKUrJMb61QDe8mxd4K64eOolu8LXkSHAOOgVdO4oaoECu61e4cLZX7xPJFfG73d
 VP2EInSbJx6NZ+XZculdyppxQQW7ixKbqO7p227c9/SzXEEO6gvhdLLZC2TciwGSGvOGE8RZptp
 N9ZkvUurO2V7887666SfLPQcLeGCo1380=
X-Gm-Gg: AR+sD12tG4FdIXzjJrf8hgECVDkhdlt5ZrBj1ogUZd2Tt0JNz3l6EAVL0qhnULDt0nZ
 NfEwBd1YK0itcz9TKxtiC9u3Q5w/YWPYwjJHpZnX8NCPi27SXe+lZeA9QRm0XQZ93vtO8AqRUu/
 RjQ8IEr+gB8J04dG9KoRr40dc68vXXX/PAmi5Tv+u30hbgq1UyKVkalnDD+T0pzOG0n9K2/JMQF
 vxppTgBAIxZ3b+tZlYNY1Mw6jdsEkMmG2qDP5V1HqVEe30FVQv5UA8P2EoztP35iJEw/mIxhYgg
 tg==
X-Received: by 2002:a05:6a21:3183:b0:3d3:adbf:7780 with SMTP id
 adf61e73a8af0-3d7b024b792mr11676540637.21.1788257905749; 
 Tue, 01 Sep 2026 03:18:25 -0700 (PDT)
X-Received: by 2002:a05:6a21:3183:b0:3d3:adbf:7780 with SMTP id
 adf61e73a8af0-3d7b024b792mr11676471637.21.1788257905240; Tue, 01 Sep 2026
 03:18:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
 <20260829-nohmp-v2-0-c5bf7b766fe7@redhat.com>
 <CAFEAcA95yjf_qr8hkPvdxj+kpF9KuU7UHkDMLWfOvfa3WqhmTQ@mail.gmail.com>
In-Reply-To: <CAFEAcA95yjf_qr8hkPvdxj+kpF9KuU7UHkDMLWfOvfa3WqhmTQ@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 1 Sep 2026 14:18:13 +0400
X-Gm-Features: AcwNN1V_CZPCn_GbkxK0lXHUPpbSbyaLbzNCZF1P_X_aLIFEGhEjDCo6QR1yCwY
Message-ID: <CAMxuvaxvSdA8jJyg76ejSNetGiScFqtZ2Nu1ZGig5h8ZcSAnjw@mail.gmail.com>
Subject: Re: [GIT PULL v2 00/50] Make HMP optional
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hi

On Tue, Sep 1, 2026 at 1:10=E2=80=AFPM Peter Maydell <peter.maydell@linaro.=
org> wrote:
>
> On Sat, 29 Aug 2026 at 10:15, <marcandre.lureau@redhat.com> wrote:
> >
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > The following changes since commit d2e570cc0f97b936902a5b1b86b73c0f5998=
b475:
> >
> >   Merge tag 'pull-ppc-for-11.2-20260828' of https://gitlab.com/harshpb/=
qemu into staging (2026-08-28 15:17:04 -0700)
> >
> > are available in the Git repository at:
> >
> >   https://gitlab.com/marcandre.lureau/qemu.git tags/nohmp-pr-v2
> >
> > for you to fetch changes up to 7ef933e532a5f86778a16f5b0074f1c2d7b87459=
:
> >
> >   gitlab: --disable-hmp in build-without-defaults (2026-08-29 12:08:21 =
+0400)
> >
> > ----------------------------------------------------------------
> > Make HMP optional
> > v2:
> >  - rebased, skip one new test
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
>
> This still fails "make check" on a local "--without-hmp" build:
>
>  118/1082 qtest+qtest-i386+slow - qemu:qtest-i386/ahci-test
>                 ERROR            4.86s   killed by signal 6 SIGABRT
>  119/1082 qtest+qtest-x86_64+slow - qemu:qtest-x86_64/ahci-test
>                 ERROR            5.58s   killed by signal 6 SIGABRT
>
> Assertion failure is
>  ERROR:../../tests/qtest/libqtest.c:998:qtest_vhmp: assertion failed: (re=
t)
>
> "make check-functional" also fails:
>
>  23/361 func-thorough+func-s390x-thorough+thorough -
> qemu:func-s390x-ccw_virtio               FAIL             22.99s
> exit status 1
> 292/361 func-thorough+func-m68k-thorough+thorough -
> qemu:func-m68k-nextcube                   FAIL              0.17s
> exit status 1
> 311/361 func-thorough+func-ppc-thorough+thorough - qemu:func-ppc-ppe42
>                        FAIL              0.20s   exit status 1
> 359/361 func-thorough+func-x86_64-thorough+thorough -
> qemu:func-x86_64-nvme_migration         FAIL             34.99s   exit
> status 1
>
> The first three all fail because the test does
>  self.vm.cmd('human-monitor-command', command_line=3D'something')
> and this throws an exception. I think the nvme one is unrelated
> and is probably some existing intermittent failure.
>
> This suggests we need to add coverage of this config to CI.

I don't see those failure immediately on my build either.
Can we adress those remaining issues after the merge if it doesn't break CI=
?

For the records, more tests were converted to QMP in an earlier
version, but left out to make the series easier to merge


