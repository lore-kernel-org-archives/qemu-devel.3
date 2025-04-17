Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1308C369C9
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 21:23:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5WgK-0000No-HA; Thu, 17 Apr 2025 17:22:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u5WgI-0000NM-Er
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 17:21:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u5WgG-00076R-3L
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 17:21:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744924913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ARwUeFH/AbXpiF9ATeO2ZoXgZbMQVisi5KpAcd2UYGQ=;
 b=enxbcBzyWUWuc9raduhK6LhfVKr+WpTNvux+qhJe4fZtICM1YyKO+LVEOqIpadlVC9xlHZ
 eI1r7qoiRKdpbDbI9cQ1uVVpX7eey5fjx+GZgYK6KW9PqSBmwbtSmt0FEnMcm+RMWlJE4/
 DrCECRShVxEe0cASL1SLvRpMxB1w/qs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-ts9UWp6xPrWY1PyJlkT1Mw-1; Thu, 17 Apr 2025 17:21:51 -0400
X-MC-Unique: ts9UWp6xPrWY1PyJlkT1Mw-1
X-Mimecast-MFC-AGG-ID: ts9UWp6xPrWY1PyJlkT1Mw_1744924910
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3912fe32a30so502276f8f.1
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 14:21:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744924910; x=1745529710;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ARwUeFH/AbXpiF9ATeO2ZoXgZbMQVisi5KpAcd2UYGQ=;
 b=u8I0jWbQ73C0XzyJ3L+UrRlitRx7nV0QXJ+mDmAHftmpOFtYnXSjC4LHr9qpWtOxOd
 G53y9DYV0dstCtv55lMlwlc6p/MNsKAGQsuZhoUA/ycQMygvxEBZbm/bReZfS+2WLAGz
 8dH3OwSZeNcsLZr9D/sYM6zK78erV1DC9VwdTkIm0R7sM15dT1HjYs2SvL9+MFVCqqRA
 iVssyB53AeExogeW5O7gYBGDlGhh74eYZNxMah0HzxeDMr075zD54L0JL6m7k7S1W9Q7
 +Rhw5CEBBYisHzV58mxjClpvL6rGV20z6cZqCMK3eifwnkq09vGeMumcDKVONPhWtCMm
 61eQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvqXHPe0vDCZLwQ8Kmu72NKocKKsxcWw7i0hUBanqrn5zybtrmOodzaEFola66uVCzfw8BXwAaK4AN@nongnu.org
X-Gm-Message-State: AOJu0Ywzh7lWzAMSNiIK4GiSrlFyij6ozilr2QmUc/HVpZ4R4edXV8+4
 eULhDyOW3wVlwGr62lu5IHOxqq/GHK6rowoErPt9zK8X4nsVp/WMO9HDFeJitvwGTqFsAeuIkVF
 kXr/GqXNUQHWJ24rZw38UyBZ0uRedY+OC7KwCapbd7y1bTZ/+v/bJ
X-Gm-Gg: ASbGnct2/rncozBdjVbTNB92BLhEsPFixWrt/8rHn9biRtaEoP1mqvyvjWwhfLnkwpu
 kaFxuVuZ29dMporE3UEEreTJlWHS2GJdJgjly4z/aWpsOSEZH1iGv6TlWfJ5XKb/M5lK2wo0JH0
 NGdYy3ySWXOMppAlFCwlG8I3GFZTf+IR6F17fsG9IBet/PJWlwQ+OCTzCih27j07Bfj5t6ZyZCr
 C2V4ynDPfzZ7kPeYiQcxzNIivprpMlRrA/hIFGp5gsYeOCOQDJ5VvjP+ALyyBYqGETElEx6yAwr
 SIgCRw==
X-Received: by 2002:a05:6000:2401:b0:391:489a:ce12 with SMTP id
 ffacd0b85a97d-39efba608ecmr334063f8f.26.1744924910454; 
 Thu, 17 Apr 2025 14:21:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeayfNkBZHuMK2O/HKlVzacIycB2xV4MaBt8hW1sdPh9208gq7SLZR8Qqjq+5a+Lunzl812Q==
X-Received: by 2002:a05:6000:2401:b0:391:489a:ce12 with SMTP id
 ffacd0b85a97d-39efba608ecmr334046f8f.26.1744924910012; 
 Thu, 17 Apr 2025 14:21:50 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406abfff1asm3872555e9.27.2025.04.17.14.21.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 14:21:49 -0700 (PDT)
Date: Thu, 17 Apr 2025 17:21:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: Igor Mammedov <imammedo@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Andrew Jones <ajones@ventanamicro.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Udo Steinberg <udo@hypervisor.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH-for-10.1 v3 6/9] qtest/bios-tables-test: Whitelist
 aarch64/virt 'its_off' variant blobs
Message-ID: <20250417172138-mutt-send-email-mst@kernel.org>
References: <20250403204029.47958-1-philmd@linaro.org>
 <20250403204029.47958-7-philmd@linaro.org>
 <671a6c82-ae10-4f3b-9d83-cecc32755206@linaro.org>
 <20250409160531.341c205e@imammedo.users.ipa.redhat.com>
 <98b2676d-ad21-4c05-a165-12ae5e1b9c64@linaro.org>
 <20250410085042.6aa5593d@imammedo.users.ipa.redhat.com>
 <ec5cec94-4d02-442e-94e6-c0c2e79f3684@linaro.org>
 <0dffbcec-ca2a-47d0-b837-2400865371f7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0dffbcec-ca2a-47d0-b837-2400865371f7@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Apr 17, 2025 at 06:06:14PM -0300, Gustavo Romero wrote:
> Hi Igor and Michael,
> 
> On 4/10/25 13:22, Gustavo Romero wrote:
> > Hi Igor,
> > 
> > On 4/10/25 03:50, Igor Mammedov wrote:
> > > On Wed, 9 Apr 2025 12:49:36 -0300
> > > Gustavo Romero <gustavo.romero@linaro.org> wrote:
> > > 
> > > > Hi Igor,
> > > > 
> > > > On 4/9/25 11:05, Igor Mammedov wrote:
> > > > > On Fri, 4 Apr 2025 00:01:22 -0300
> > > > > Gustavo Romero <gustavo.romero@linaro.org> wrote:
> > > > > > Hi Phil,
> > > > > > 
> > > > > > On 4/3/25 17:40, Philippe Mathieu-Daudé wrote:
> > > > > > > We are going to fix the test_acpi_aarch64_virt_tcg_its_off()
> > > > > > > test. In preparation, copy the ACPI tables which will be
> > > > > > > altered as 'its_off' variants, and whitelist them.
> > > > > > > 
> > > > > > > Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
> > > > > > > Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > > > > > > ---
> > > > > > >     tests/qtest/bios-tables-test-allowed-diff.h |   3 +++
> > > > > > >     tests/qtest/bios-tables-test.c              |   1 +
> > > > > > >     tests/data/acpi/aarch64/virt/APIC.its_off   | Bin 0 -> 184 bytes
> > > > > > >     tests/data/acpi/aarch64/virt/FACP.its_off   | Bin 0 -> 276 bytes
> > > > > > >     tests/data/acpi/aarch64/virt/IORT.its_off   | Bin 0 -> 236 bytes
> > > > > > >     5 files changed, 4 insertions(+)
> > > > > > >     create mode 100644 tests/data/acpi/aarch64/virt/APIC.its_off
> > > > > > >     create mode 100644 tests/data/acpi/aarch64/virt/FACP.its_off
> > > > > > >     create mode 100644 tests/data/acpi/aarch64/virt/IORT.its_off
> > > > > > > 
> > > > > > > diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> > > > > > > index dfb8523c8bf..3421dd5adf3 100644
> > > > > > > --- a/tests/qtest/bios-tables-test-allowed-diff.h
> > > > > > > +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> > > > > > > @@ -1 +1,4 @@
> > > > > > >     /* List of comma-separated changed AML files to ignore */
> > > > > > > +"tests/data/acpi/aarch64/virt/APIC.its_off",
> > > > > > > +"tests/data/acpi/aarch64/virt/FACP.its_off",
> > > > > > > +"tests/data/acpi/aarch64/virt/IORT.its_off",
> > > > > > 
> > > > > > I think your first approach is the correct one: you add the blobs
> > > > > > when adding the new test, so they would go into patch 5/9 in this series,
> > > > > > making the test pass without adding anything to bios-tables-test-allowed-diff.h.
> > > > > > Then in this patch only add the APIC.its_off table to the bios-tables-test-allowed-diff.h
> > > > > > since that's the table that changes when the fix is in place, as you did in:
> > > > > 
> > > > > if APIC.its_off is the only one that's changing, but FACP/IORT blobs are the same
> > > > > as suffix-less blobs, one can omit copying FACP/IORT as test harness will fallback
> > > > > to suffix-less blob if the one with suffix isn't found.
> > > > 
> > > > OK. Just clarifying and for the records, this is not the case for this series
> > > > 
> > > > 
> > > > > if blobs are different from defaults then create empty blobs and whitelist them in the same patch
> > > > > then do your changes and then update blobs & wipeout withe list.
> > > > 
> > > > Thanks for confirming it. That's what I suggested to Phil in my first review and what
> > > > I understood from the prescription in bios-tables-test.c.
> > > > 
> > > > However, on second thoughts, for this particular series, isn't it better to have the following commit sequence instead:
> > > > 
> > > > 1) Add the new test and the new blobs that make the test pass, i.e. APIC.suffix, FACP.suffix, and IORT.suffix (they are different than the default suffix-less blobs)
> > > 
> > > blobs should be a separate commit (that way it's easier for maintainer to rebase them,
> > > if they clash during merge with some other change.
> > 
> > I see. What is a bit confusing here is that the series consists in
> > one blob addition act (for the new test) and one blob update/removal act (after the fix).
> > 
> > 
> > > > 2) Whitelist only the APIC.suffix since that's the table that will change with the fix
> > > > 3) Add the fix (which changes the APIC table so a new APIC.suffix blob is needed and also stops generating the IORT table, so no more IORT.suffix blob is necessary)
> > > > 4) Finally, update only the APIC.suffix blob and remove the IORT.suffix blob and wipe out the whitelist
> > > > 
> > > > This way:
> > > > 
> > > > A) It's clear that only ACPI blob changed with the fix, because there is no addition of a FACP.suffix blob in 4) (it remains the same)
> > > > B) It's clear that the IORT table is removed with the fix and is not relevant anymore for the test
> > > 
> > > I'd just mention it in commit log so  that later no one would wonder why we are adding and then removing tables
> > > 
> > > As for the rest of suggestions, it looks fine to me.
> > 
> > Well, 2) won't make sense anymore since APIC.suffix would be already in the
> > whitelist in the previous patch that added the empty blobs. Since there won't
> > be a commit that adds _only_ the APIC.suffix to the whitelist, in preparation
> > for the fix, this info is "lost" in the series, even tho it's possible to
> > mention in the commit message.
> > 
> > Hence, what I think is not ideal from a maintainer's/reviewer's perspective,
> > is that in one commit all the blobs are updated/removed at once, which is
> > confusing because the fix did not touch the FACP table (for instance) and
> > this table is updated with APIC and with the removal of IORT, altogether,
> > in the last commit.
> > 
> > So, for this series, which adds new blobs and _also_ updates and removes some
> > of them, how about the following organization:
> > 
> > - Patch 1     : Add the new test, add the empty blobs *.suffix files, whitelist such a blobs
> > - Patch 2     : Update the blobs in Patch 1 with the ones that make the new test pass and remove them from the whitelist
> > 
> > - Patch 3     : Add the APIC.suffix blob to the whitelist (the table that changes due to the fix)
> > - Patch 4 - n : Fix(es)
> > - Patch (n+1) : Update the APIC.suffix blob, remove IORT.suffix blob, and remove the APIC.suffix blob from the whitelist
> >                * Add the APIC diff to the commit log
> >                * Mention in the commit log that IORT.suffix is removed because IORT table is no long generated after the fix
> > 
> > This way: a) no commit fails the test and b) blobs are added/updated/removed in separate commits
> > 
> > What do you think?
> 
> I’d really appreciate it if you could confirm whether this organization makes sense.
> 
> 
> Cheers,
> Gustavo

looks ok. Igor?


