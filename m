Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB1DC0218F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 14:39:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdVgs-000236-97; Thu, 30 Jan 2025 09:38:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tdVgl-0001yd-1B
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 09:38:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tdVgj-0002k4-8y
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 09:38:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738247915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JgiE4FoOzUtDiv/Mw5xRoxpuCcm6arbkAbYB7wDmIE4=;
 b=KpUYCp613mPeIX+hbp+IypRsfob+5XobrckxJJd5eJ7uVqmh8lgxF4+VQh3mv15VFipHHg
 a8MAJ4LPfA2EAmOBP+DNzaf98wu2cvsGPFlGAZ5/LUyCafyg97MDrYABzmy4huvPrz83un
 SmOVuPR7gkm0RFL54NzlI1teqZdPE14=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-pjW7HePtOhOpcE1-5MQPJQ-1; Thu, 30 Jan 2025 09:38:34 -0500
X-MC-Unique: pjW7HePtOhOpcE1-5MQPJQ-1
X-Mimecast-MFC-AGG-ID: pjW7HePtOhOpcE1-5MQPJQ
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-385ded5e92aso389104f8f.3
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 06:38:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738247913; x=1738852713;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JgiE4FoOzUtDiv/Mw5xRoxpuCcm6arbkAbYB7wDmIE4=;
 b=jvzuLTqUbF3YPx4fxBgreAdOBIjtKwkRyQVyRd8TXUC/8JYX+UiWV65nDTQenkhJRq
 Khf4Ri5Aoum7LMQEsh4nvh1ftWhQ/014pLKm7TwOc5iCidagQulMa8L/oceQQSGeDBku
 k9WUcqZLGWRf0N7DaYXKbdRmK/9DBGOmi0FhUkPjmc9NAibkLCEefFgfKn5lWueZpxBG
 ojF+I14uC0d8M5bhRemlRZKugzrvAk8HZQ0s8RjMEkARiY6Uc/ScsN1I82dS/ertj+I6
 qarUjw+DsL4KNYlSXpDfFQHX8OIgghTevwv56EX6lCzf7IF0xSeG5q6K7vv67w7hxQ0Z
 HGkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZvJmy5XePIyvaokaFgd4aANYPWzSGVToQvPCrfxHgVjzAcSW7rWK3LK9qzXZD8oXmwMT9Iea9Adks@nongnu.org
X-Gm-Message-State: AOJu0YyqusoH4qoWk5dq7MBJeAqG9CWdhWiz9dipHPyv0PLEJBOjRD3R
 RqS+GAV1MqiZXcPLbMULnXot0G5cAYmtrsUtqdKlpqh2Zv+5TwkptZ7iDWkfUFhoK/LlL3rYvPc
 Aw5b5DAAKaKS1QuvuGvmXJFyiaTmvyV+kB6SzSH7xYxGnOzlXFjXX
X-Gm-Gg: ASbGncsf6XUFGwQNef8MI1FapjMQ7BUno6Ge28LbF9L5Ahu81z0JP733KIBaiqfDiWH
 QKlZAzrQEGznFzdf8PbaSQ/viWPNOOPjCJnZmtzGBRCI+wI9zA5nkdBqot05CYFJf/bFrSCHpcj
 VwvvWSjmFXjiCwIbxsMc1RE7IvkiQeufQVUJCakcVEOTaZbOQvL3Ume1MAw6ZJurOw2ucfmlCN3
 F4haQLL/Ske7xG35pBikA8G61JzP7kf4wZJzsNjrtGE0KGj48vwivLM/jsIzOh/iaK/OLPLanL0
 x+pFElhYYw7RFKiqtBqBeAlHWZ2AWqwdVnWZRjbgf0hpNcfMynIb
X-Received: by 2002:a05:6000:1882:b0:38b:f03c:5bbc with SMTP id
 ffacd0b85a97d-38c5195e5fcmr5088127f8f.19.1738247913084; 
 Thu, 30 Jan 2025 06:38:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbV/sWshrdZhajcEm6ev76AV43Yg6Ta4vaWNe4sJ9G1m559H1nibuG1D9Z7w1qHPW2kocQNA==
X-Received: by 2002:a05:6000:1882:b0:38b:f03c:5bbc with SMTP id
 ffacd0b85a97d-38c5195e5fcmr5088104f8f.19.1738247912662; 
 Thu, 30 Jan 2025 06:38:32 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc2f17dsm60641185e9.23.2025.01.30.06.38.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jan 2025 06:38:31 -0800 (PST)
Date: Thu, 30 Jan 2025 15:38:30 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Ani Sinha
 <anisinha@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/13] tests/acpi: virt: allow acpi table changes for
 a new table: HEST
Message-ID: <20250130153830.2e4e081d@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250130140324.06cdd4bf@foz.lan>
References: <cover.1738137123.git.mchehab+huawei@kernel.org>
 <1390b46682f2bac3587239d03a0ba22d18a9a044.1738137123.git.mchehab+huawei@kernel.org>
 <20250129160328.2f66584c@imammedo.users.ipa.redhat.com>
 <20250130140324.06cdd4bf@foz.lan>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
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

On Thu, 30 Jan 2025 14:03:24 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Wed, 29 Jan 2025 16:03:28 +0100
> Igor Mammedov <imammedo@redhat.com> escreveu:
> 
> > On Wed, 29 Jan 2025 09:04:08 +0100
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> >   
> > > The DSDT table will also be affected by such change.
> > > 
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>    
> > 
> > move it right before the patch that would actually make changes to tables (10/13)  
> 
> Table changes happens on two patches:
> 
> - patch 03/13: acpi/ghes: add a firmware file with HEST address

this one shouldn't affect bios tables test as it only checks ACPI and SMBIOS tables,
and hest addr file is not either.

Do you really see test failing on this patch?


> 	HEST table was added here
> 
> - patch 10/13: arm/virt: Wire up a GED error device for ACPI / GHES 
> 
> 	DSDT changes happen here.
> 
> If the idea is to avoid make check to fail between those two patches,
> we need either to split them on 4 patches (one before/one after each
> change) or do like I did on this series: whitelist before patch 3,
> update after patch 10.

It would be better to group patches that should change ACPI tables
close together so that a pair of whitelist/update could cover it.
However it depends on how many changes are there, i.e. acpi diff
should be digestible for a reader. So there is no hard border here,
just use common sense.

However when the whitelist is covers all series where only few patches
actually result in tables change, that miss-leads the reader since
whitelist patch basically tells 'watch out for changes since this moment'
and 'update' patch declares no more changes should happen.
The same applies to bisection, where closer the gap between
whitelist/update the better if the test case is the trigger.
No need to be fanatical and do it around each patch,
just make it observable (i.e. some small range of commits). 

  
> 
> Regards,
> Mauro
> 
> > 
> >   
> > > ---
> > >  tests/data/acpi/aarch64/virt/HEST           | 0
> > >  tests/qtest/bios-tables-test-allowed-diff.h | 2 ++
> > >  2 files changed, 2 insertions(+)
> > >  create mode 100644 tests/data/acpi/aarch64/virt/HEST
> > > 
> > > diff --git a/tests/data/acpi/aarch64/virt/HEST b/tests/data/acpi/aarch64/virt/HEST
> > > new file mode 100644
> > > index 000000000000..e69de29bb2d1
> > > diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> > > index dfb8523c8bf4..46298e38e7b8 100644
> > > --- a/tests/qtest/bios-tables-test-allowed-diff.h
> > > +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> > > @@ -1 +1,3 @@
> > >  /* List of comma-separated changed AML files to ignore */
> > > +"tests/data/acpi/aarch64/virt/HEST",
> > > +"tests/data/acpi/aarch64/virt/DSDT",    
> > 
> > the list in not complete so 'make check-qtest' still fails
> > [12/13] has complete list of changed files
> >   
> 
> 
> 
> Thanks,
> Mauro
> 


