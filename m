Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D41B1C79F9E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 21:17:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3ghq-0001ly-Vw; Mon, 07 Sep 2026 17:16:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x3ghp-0001li-Ua
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 17:16:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x3ghn-0000So-UB
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 17:16:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788815802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mw8RFV/2HjpqWkwUwmTokzDl1/223/6QlsoHVWfboPU=;
 b=ZQtJQT+40FKV+Cp9d46ynUejfzV12UVRwU8Ad3AM3z50pCN1T+/548tCShRX7Y6zrjnyKS
 vSqGEUMpsKaWILMloK4Ytw47sYaKg4/uXqHAgNe7A+QJQx1EAvmpTDZ+LW3NHBZOuEV8yw
 NxrMsgqgAHLjxYwTFGnlQN8UF2ZEjB4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-BPNs2DabNra9LqNUkIHehA-1; Mon, 07 Sep 2026 17:16:41 -0400
X-MC-Unique: BPNs2DabNra9LqNUkIHehA-1
X-Mimecast-MFC-AGG-ID: BPNs2DabNra9LqNUkIHehA_1788815800
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-484337a63bbso2342838f8f.3
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 14:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788815800; x=1789420600; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mw8RFV/2HjpqWkwUwmTokzDl1/223/6QlsoHVWfboPU=;
 b=Pk/vuo67rRIZsqawRb79YYinUvHCfUVvfRUrqR3gG6thYMuHybYblOi7dhJhhzRn2c
 wBniEoaIOTjTkEBTdsoUCq8V42XzVmD2sJMBSB5Fpl1guolglGHTUZBvqCZZymdQTbaN
 hbqPKVLITSZ8Mo5P9CFgTP59SW+Grvn8NHjKvBq0gAJNP9Z/3san81lo0FpVT1mvRMFS
 79RFdsKZyURdGrVciKPgF+Am2GMk8fBtBbAXydPhMIyDDITNsXO7+4REXUmUXKxmWxIH
 JW8vKFAj95mXJORlN+KjLE5iOWWtKxwqBvOsdttSbhnCv3QGs4F/5wSodfKwNmHjX1zK
 SPPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788815800; x=1789420600;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mw8RFV/2HjpqWkwUwmTokzDl1/223/6QlsoHVWfboPU=;
 b=F29SKKSHxZs2uVoSp5QvMM7i5pgGfZLtktqZKZZaD3XCOZiK6rb29QLWhK9t/kALVL
 VmyGva3G/ApvK8baibQhjW0UhFAWMQzhlOt813mYyZyU653eA+hHVb0/9fjgjm4uvw2B
 WmoWpkQaE1t5GoGO+Q5D1SQkiqgRxtgfi96eGCHWzYJqt7Sd8JVIQ1K253j76PoRmeb5
 vC5OstzaSTUEvHiMJYA1qLjiYSoELWaqanBneUapdACqYpaASch2QiRgay4AXgnRuPqJ
 l5NbFGJZQ0VNCIREHXOg+azzcnRf8twSjIJ8W/dKltcLrCJvJXiPMM3JrzcTmPS6ZxZL
 mWpQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByB8M76r3kDhwwvWo1wqNFfo8CHOzb4vo3opfNaSMUd9ek2Rk5M3I7ZqnhKMe5NIflv27FBKOkTNcDR@nongnu.org
X-Gm-Message-State: AFuF++k1LQ8OP8941RD/JxomKUjHhf1wA74M5f7EoWbx8T4NwH9Lf/iX
 AWTXnqezesnU+kI1P+Ffr5hRy5Q/wb/xamaSdgGhubP9FgmZDJHZm9uz3553Yde0p/2/klJiqcL
 sKRl0TIv5iJhi0SckERYoYPToSLKIcMPTsaoteU2o3kOJtc/Qx+TeXyhC
X-Gm-Gg: AYBFou2OV1i0XDnRrY5f//CLX2tqjSD1HQ/zwGHCmAAnsFjCmJlq3mu+/2z8x8qKQpA
 fKeItn4kQ9SCFk/bRqqjlUve3Ywvme4Q6aV6bmn7Y+oUS+Gb6hsTdI56ceuQNNRIjabP4sZ8GTb
 wja0bU6NgoN2ptBTbTwn2BxBuzoZs8XkvE6qycLJ52UeAbDMZEsXkkClBYSMXcS175+UrbG5ZK5
 C6MedUuVTDauag3JJXLlgRdhT5R25tpmPE0VfQGrFm5xY31KCMtU6l8k9RD+ME1UAwx59RZRDXz
 bAtRXLvU2h4VXNlCn8/IF3KzRGvpaPItmjhNx0QEhHUE0NRM31X/cUmdqa09wka4q08aWxc8/Wk
 VzsOOHI9ySzqX9/igvjCdD4E=
X-Received: by 2002:a05:6000:1a52:b0:481:51ce:542f with SMTP id
 ffacd0b85a97d-485872b40e3mr21034571f8f.21.1788815799868; 
 Mon, 07 Sep 2026 14:16:39 -0700 (PDT)
X-Received: by 2002:a05:6000:1a52:b0:481:51ce:542f with SMTP id
 ffacd0b85a97d-485872b40e3mr21034526f8f.21.1788815799406; 
 Mon, 07 Sep 2026 14:16:39 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4858e239862sm26191451f8f.9.2026.09.07.14.16.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 14:16:38 -0700 (PDT)
Date: Mon, 7 Sep 2026 17:16:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: Igor Mammedov <imammedo@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 xen-devel@lists.xenproject.org, dave@treblig.org,
 anisinha@redhat.com, philmd@mailo.com, aurelien@aurel32.net,
 mjrosato@linux.ibm.com, alifm@linux.ibm.com, farman@linux.ibm.com,
 richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, cohuck@redhat.com,
 alex@shazbot.org, clg@redhat.com, akrowiak@linux.ibm.com,
 jjherne@linux.ibm.com, sstabellini@kernel.org,
 anthony@xenproject.org, edgar.iglesias@gmail.com,
 pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com,
 joe.jin@oracle.com
Subject: Re: [PATCH 0/8] Force detach PCI devices for ACPI-based and PCIe
 native hot-unplug
Message-ID: <20260907171522-mutt-send-email-mst@kernel.org>
References: <20260824011420.752806-1-dongli.zhang@oracle.com>
 <aoxY4Rxst2qAyn5z@redhat.com>
 <01ee4841-76d8-4749-a80e-eb945ab8799a@oracle.com>
 <20260903172835.0e253a25@imammedo>
 <6154b857-16b3-476b-a2cb-8837464dd4cb@oracle.com>
 <20260907044608-mutt-send-email-mst@kernel.org>
 <296a04a7-f917-4abd-b564-4a6b8fc6aace@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <296a04a7-f917-4abd-b564-4a6b8fc6aace@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Sep 07, 2026 at 02:06:29PM -0700, Dongli Zhang wrote:
> 5. By instrumenting QEMU code and possibly adding additional metadata, we can
> track whether a PCI device has been accessed by the guest VM, especially during
> PCI hotplug. If the device has never been used by the guest VM, it may be safer
> to force-detach it.

this last one I am not sure about. as I said, devices are commonly
accessed by firmware.


