Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EC60CD4F39
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 13:34:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNWCn-0003KF-CW; Thu, 14 May 2026 09:34:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wNWCj-0003Jz-49
 for qemu-devel@nongnu.org; Thu, 14 May 2026 09:34:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wNWCh-00018R-I1
 for qemu-devel@nongnu.org; Thu, 14 May 2026 09:34:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778765658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CDR8XOuvHDjk3L20OEV9oAWrm2f9Z3ae1J0fTZ4bBHQ=;
 b=PExjmxb9oeTooNC5dDDr1PyGZ+Wo06D4RhXn5TWRROmF1aHOwJjqtOH3Ys4fmDQ+J/5jil
 m/UFa+F7qTPUHbLlc25nBd8JOrfYlXf0erau3sjXv5PG1nXCoPO5ao/QIqtXpUuMvVyGYe
 t5Eojyw3JFbQMVITPmB8eVMzNWoJxWc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-tef9tsEzOTCSfg280eBMKA-1; Thu, 14 May 2026 09:34:17 -0400
X-MC-Unique: tef9tsEzOTCSfg280eBMKA-1
X-Mimecast-MFC-AGG-ID: tef9tsEzOTCSfg280eBMKA_1778765656
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-44d9ace59efso5349922f8f.1
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 06:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778765656; x=1779370456; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CDR8XOuvHDjk3L20OEV9oAWrm2f9Z3ae1J0fTZ4bBHQ=;
 b=e6KbWBcyekHAzGmyeUqqhfOQnA1MX6iAIyS36wqTIPhncnZ1dlZQ82PwUkK+r4mI7l
 kMISSsbZKKo3cELW8jxiIYzaEvhL7n3CfMYh1pC1VjtaVkAIuynGWN8+z4v+BdYM5b3o
 6sk8R6VYMJJHKxUaLHlpPrdzMeuziwc1DP6DBgpm4yw318XNGdf7+a+CUPUO3peqfzrV
 qqTV7poG6juHIHyjOkR0iRcWH8cICRlQo2JUXggG5WbD+QHjAPQkP0G216icX/D8XbxW
 rbgds+KUzDuAuc3n22jdWtl4pBHdAOstFwFItII7K2e3G6CrwBtT/FF7/MgIxugEvJvl
 6plw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778765656; x=1779370456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CDR8XOuvHDjk3L20OEV9oAWrm2f9Z3ae1J0fTZ4bBHQ=;
 b=tH1Q1WOvvy1J/g3nhnuNyzuzBKbyDt+4br+fsRXMkWWAoWBd1BSCRLdzcqlDVzXb8G
 KoipayAqLDGJk6v7A70LlF/Klr7wVyLO8qBZx1zLJ9ugvR8jG1G7jTZNmgT+t2dNcBbD
 5Vp0lhO4dBodpUcoO7h2DZmaKjkiRTVhi17mcLe83/8mSyES29eq8FN+AcIUyW5JKW+c
 8H4m1dUa7mYZHveSUckc2sbHLAGZlkJ0+v40zgvYDwUstbDApOvYtM4mTSUD1AUmYS19
 Jb3bN5dMAq7Q01h57eLTWSbLFW2dn0BSxJtfau8UU2irpp4CUoML9OIES7S95TCpJHRB
 Ow6A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+O/YKgI3NGhGZr6ZEHOKAtJ0PoopYazUgQQGgj9fNwXqBUgWdOm0ND8r8JjNLX/zG4e/6+O0qzwjeG@nongnu.org
X-Gm-Message-State: AOJu0Yz3ephk6Zs5YjQQgSfzQSlwWBaoUYjB/FMKJ1xgKCRuMRps9XQF
 vZO0U3El/xCt+I9q59AdyUGR3UGI//yWXOWQOwMrftG0GG+s99MQuxRoJzzsFVb1N86yIPJxbaW
 Wz/daNS1+Vxgo8K8PorC7dqbhc4suvt4eFrq5Sgw0kYtlHgxVJB2TPbw+
X-Gm-Gg: Acq92OGsIvygmgjvXaCsTSAOlZZB1HwrEON1lbqmKoMf2Dzsur/sSLjEBBlEVgZH3iW
 QyInMnlf0xZHCoNowTQeZIAvvRfh+mfr1XmxjnjHfqjIHbl1HENMkMeZSDKGMt/yv1JMCXDOgPK
 IRvOYNgYWbTrGgNNVOkZMkyC/yDt4TIZuBV/nZQxW0Zn2HQEnjPSs8sT7yjgkklXolFEIb2epqn
 KyUzLFz8JhIZdxUTJvKUE4MtiPkXvNWTu/Bs7nyJP1662qHdR1KlnA3G8tFdoPl08pda6BJQ2ro
 9PB5GSxEVytlk6ucWJfrqy/RsfBK7ZMltvHd95x7rhJ3I1gX6yTKL44ObhRdqtAN+1Z//dKpP17
 L4/ykXA==
X-Received: by 2002:a05:6000:200c:b0:451:3b12:9bca with SMTP id
 ffacd0b85a97d-45c59228b15mr12625769f8f.25.1778765656059; 
 Thu, 14 May 2026 06:34:16 -0700 (PDT)
X-Received: by 2002:a05:6000:200c:b0:451:3b12:9bca with SMTP id
 ffacd0b85a97d-45c59228b15mr12625665f8f.25.1778765655261; 
 Thu, 14 May 2026 06:34:15 -0700 (PDT)
Received: from imammedo ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0a1aeafsm6804003f8f.23.2026.05.14.06.34.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 06:34:14 -0700 (PDT)
Date: Thu, 14 May 2026 15:34:14 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: mst@redhat.com, anisinha@redhat.com, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 2/4] tests/acpi: allow DSDT acpi table changes
Message-ID: <20260514153414.301290c6@imammedo>
In-Reply-To: <20260508101901.930781-3-mark.caveayland@nutanix.com>
References: <20260508101901.930781-1-mark.caveayland@nutanix.com>
 <20260508101901.930781-3-mark.caveayland@nutanix.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri,  8 May 2026 11:17:41 +0100
Mark Cave-Ayland <mark.caveayland@nutanix.com> wrote:

> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>

Acked-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  tests/qtest/bios-tables-test-allowed-diff.h | 47 +++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index dfb8523c8b..cef44135bc 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1 +1,48 @@
>  /* List of comma-separated changed AML files to ignore */
> +"tests/data/acpi/x86/pc/DSDT",
> +"tests/data/acpi/x86/pc/DSDT.bridge",
> +"tests/data/acpi/x86/pc/DSDT.ipmikcs",
> +"tests/data/acpi/x86/pc/DSDT.cphp",
> +"tests/data/acpi/x86/pc/DSDT.numamem",
> +"tests/data/acpi/x86/pc/DSDT.nohpet",
> +"tests/data/acpi/x86/pc/DSDT.memhp",
> +"tests/data/acpi/x86/pc/DSDT.dimmpxm",
> +"tests/data/acpi/x86/pc/DSDT.acpihmat",
> +"tests/data/acpi/x86/pc/DSDT.acpierst",
> +"tests/data/acpi/x86/pc/DSDT.roothp",
> +"tests/data/acpi/x86/pc/DSDT.hpbridge",
> +"tests/data/acpi/x86/pc/DSDT.hpbrroot",
> +"tests/data/acpi/x86/q35/DSDT",
> +"tests/data/acpi/x86/q35/DSDT.tis.tpm2",
> +"tests/data/acpi/x86/q35/DSDT.tis.tpm12",
> +"tests/data/acpi/x86/q35/DSDT.bridge",
> +"tests/data/acpi/x86/q35/DSDT.noacpihp",
> +"tests/data/acpi/x86/q35/DSDT.multi-bridge",
> +"tests/data/acpi/x86/q35/DSDT.ipmibt",
> +"tests/data/acpi/x86/q35/DSDT.cphp",
> +"tests/data/acpi/x86/q35/DSDT.numamem",
> +"tests/data/acpi/x86/q35/DSDT.nohpet",
> +"tests/data/acpi/x86/q35/DSDT.acpihmat-noinitiator",
> +"tests/data/acpi/x86/q35/DSDT.acpihmat-generic-x",
> +"tests/data/acpi/x86/q35/DSDT.memhp",
> +"tests/data/acpi/x86/q35/DSDT.dimmpxm",
> +"tests/data/acpi/x86/q35/DSDT.acpihmat",
> +"tests/data/acpi/x86/q35/DSDT.mmio64",
> +"tests/data/acpi/x86/q35/DSDT.acpierst",
> +"tests/data/acpi/x86/q35/DSDT.applesmc",
> +"tests/data/acpi/x86/q35/DSDT.pvpanic-isa",
> +"tests/data/acpi/x86/q35/DSDT.ivrs",
> +"tests/data/acpi/x86/q35/DSDT.type4-count",
> +"tests/data/acpi/x86/q35/DSDT.core-count",
> +"tests/data/acpi/x86/q35/DSDT.core-count2",
> +"tests/data/acpi/x86/q35/DSDT.thread-count",
> +"tests/data/acpi/x86/q35/DSDT.thread-count2",
> +"tests/data/acpi/x86/q35/DSDT.viot",
> +"tests/data/acpi/x86/q35/DSDT.cxl",
> +"tests/data/acpi/x86/q35/DSDT.ipmismbus",
> +"tests/data/acpi/x86/q35/DSDT.xapic",
> +"tests/data/acpi/x86/microvm/DSDT",
> +"tests/data/acpi/x86/microvm/DSDT.usb",
> +"tests/data/acpi/x86/microvm/DSDT.rtc",
> +"tests/data/acpi/x86/microvm/DSDT.ioapic2",
> +"tests/data/acpi/x86/microvm/DSDT.pcie",


