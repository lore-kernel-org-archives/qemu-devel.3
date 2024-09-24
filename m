Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10AC1CF9C6B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 13:15:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1st5NP-0008UJ-QR; Tue, 24 Sep 2024 09:14:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1st5NJ-0008An-Qf
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 09:14:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1st5NF-0001py-5P
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 09:14:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727183675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WnqnOjUIPUpooUWJE3Ky/GdGjOl8rnVXhYBy8Sl0MF8=;
 b=Fz/bkUraP8B5rsCxxuo2KFlpViLk+ZI0B9LEd+GxSS8PEaxari2Ot44piuNf48tzim0rez
 e0msmxWCWdPeF374y4IcGQwhZbZX5wu2+yTq8k6vBe5u6jual8BK2dEUxrLzF7aexPnS1A
 gHR11rIT19S/bxSkMXxZ6S/sshRMZ8w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-zIsZr3xIMMidS55OKfbLHg-1; Tue, 24 Sep 2024 09:14:33 -0400
X-MC-Unique: zIsZr3xIMMidS55OKfbLHg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42e611963c2so36466585e9.1
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2024 06:14:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727183671; x=1727788471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WnqnOjUIPUpooUWJE3Ky/GdGjOl8rnVXhYBy8Sl0MF8=;
 b=dgvSDbha72iZEIK6mP5Yej0BCG/o72v8siLpQHT4+s6zCzHVPa+neItnIaH7K96GPI
 a7DLgWPdJjtr5QfYztAgFdeDIAifgXNw0MxVCLOQ3dHnHvpUixCOMcya7nfVGP8ArETP
 SnESmFpAKcsowOzGueF7vmqaYhgmRKgivPr3V1D4WzF3LRNaoeK/3zD6E40Ww+hMQknw
 CaKBHjhuqYsS1Tf4wkuyBPNnKXd78710EP1gZGClKbH50Ttn2kKgj+b3Y5+t6EwrP8DL
 pjLQbznz/biPRONbyVkFmVm8jpOb/OJGf77JHZjyeLGixqZMYgOFqYtGxsYV2Z5aKOUP
 qfqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3AZrraqeEn9tmn/JvS4lWtfQWj/Y2wQJd8tid1NgMMX2/G2ObRNn6rNyRpAiiOTPe6uufQsy1VnVk@nongnu.org
X-Gm-Message-State: AOJu0YyQAWAMsutYlzIx2xWqzPd9bxjYSPQ91dKTzXfCl1tuhuPzprJZ
 RjlwqXnc+JnBwfo+PNVcEXIMGGCB0QN/pIBLVZzXE5DdO0JTJRekUnPGP2AtZsRe3dYaCyTYn5W
 ahfxVk0c4dQTpGqaC9bFjW0OFtvkhSn06xEZHeYR5MjDe3AtFECM6
X-Received: by 2002:a05:600c:3d93:b0:42c:b4f1:f281 with SMTP id
 5b1f17b1804b1-42e7add23b6mr116891105e9.34.1727183671463; 
 Tue, 24 Sep 2024 06:14:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH02yYDg2GnwV59jQ/z5MRMzf+D+n23jjMcw2cOcouZAwzlFZRBg0waUfsQ0V7QZ7qLA1mz1w==
X-Received: by 2002:a05:600c:3d93:b0:42c:b4f1:f281 with SMTP id
 5b1f17b1804b1-42e7add23b6mr116890835e9.34.1727183670954; 
 Tue, 24 Sep 2024 06:14:30 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e902b65d5sm22006755e9.38.2024.09.24.06.14.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2024 06:14:30 -0700 (PDT)
Date: Tue, 24 Sep 2024 15:14:29 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Cleber Rosa <crosa@redhat.com>, Dongjiu Geng
 <gengdongjiu1@gmail.com>, Eric Blake <eblake@redhat.com>, John Snow
 <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth
 <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v10 00/21] Add ACPI CPER firmware first error injection
 on ARM emulation
Message-ID: <20240924151429.3e758b38@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240924150058.4879abe9@foz.lan>
References: <cover.1726293808.git.mchehab+huawei@kernel.org>
 <20240917141519.57766bb6@imammedo.users.ipa.redhat.com>
 <20240924150058.4879abe9@foz.lan>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.09,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 24 Sep 2024 15:00:58 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Tue, 17 Sep 2024 14:15:19 +0200
> Igor Mammedov <imammedo@redhat.com> escreveu:
> 
> > I'm done with this round of review.
> > 
> > Given that the series accumulated a bunch of cleanups,
> > I'd suggest to move all cleanups/renamings not related
> > to new HEST lookup and new src id mapping to the beginning
> > of the series, so once they reviewed they could be split up into
> > a separate series that could be merged while we are ironing down
> > the new functionality.   
> 
> I've rebased the series placing the preparation stuff (cleanups
> and renames) at the beginning. So, what I have now is:
> 
> 1) preparation patches:
> 
> 41709f0898e1 acpi/ghes: get rid of ACPI_HEST_SRC_ID_RESERVED
> 5409daa41c78 acpi/ghes: simplify acpi_ghes_record_errors() code
> 2539f1f662b9 acpi/ghes: better handle source_id and notification
> 3f19400549c1 acpi/ghes: Remove a duplicated out of bounds check
> f0b06ecede46 acpi/ghes: Change the type for source_id
> 9f08301ac195 acpi/ghes: Prepare to support multiple sources on ghes
> 2426cd76e868 acpi/ghes: make the GHES record generation more generic
> 3fb7ec864700 acpi/ghes: better name GHES memory error function
> 1a22dad3211e acpi/ghes: don't crash QEMU if ghes GED is not found
> 726968d4ee20 acpi/ghes: rename etc/hardware_error file macros
> f562380da7ce docs: acpi_hest_ghes: fix documentation for CPER size

> 69850f550f99 acpi/generic_event_device: add an APEI error device
this one doesn't belong to clean ups, I think.
Lets move this to #3 part

> 
> Patches were changed to ensure that they won't be add any new
> new features. They are just code shift in order to make the diff
> of the next patches smaller.
> 
> There is a small point here: the logic was simplified to only
> support a single source ID (I added an assert() to enforce it) and
> simplified the calculus in preparation for the HEST and migration
> series.
> 
> 
> 2) add a BIOS pointer to HEST, using it. The migration stuff
> will be along those:
> 
> c24f1a8708e3 acpi/ghes: add a firmware file with HEST address
> 853dce23ec39 acpi/ghes: Use HEST table offsets when preparing GHES records
> c148716fd7c8 acpi/generic_event_device: Update GHES migration to cover hest addr
> 
> Up to that, still no new features, but the offset calculus will be
> relative to HEST table and will use the bios pointers stored there;
> 
> 3) Add support for generic error inject:
> 
> f5ec0d197d82 acpi/ghes: add a notifier to notify when error data is ready
> f5e015537209 arm/virt: Wire up a GED error device for ACPI / GHES
> 3b6692dbf473 qapi/acpi-hest: add an interface to do generic CPER error injection
> 620a5a49f218 scripts/ghes_inject: add a script to generate GHES error inject
> 
> 4) MPIDR property:
> 2dd6e3aae450 target/arm: add an experimental mpidr arm cpu property object
> 02c88cd4daa2 scripts/arm_processor_error.py: retrieve mpidr if not filled
> 
> I'm still testing if the rebase didn't cause any issues. So, the above
> may still change a little bit. I also need to address your comments to the
> cleanup patches and work at the migration, but just want to double check if
> this is what you want.
> 
> If OK to you, my plan is to submit you the cleanup patches after I
> finish testing the hole series.
> 
> The migration logic will require some time, and I don't want to bother
> with the cleanup stuff while doing it. So, perhaps while I'm doing it,
> you could review/merge the cleanups.
> 
> We can do the same for each of the 4 above series of patches, as it
> makes review simpler as there will be less patches to look into on
> each series.
> 
> Would it work for you?

other than nit above, LGTM

> 
> Thanks,
> Mauro
> 


