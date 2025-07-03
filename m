Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE33C83F03
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 21:22:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXRNU-0003Fh-Nv; Thu, 03 Jul 2025 17:21:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uXRNL-0003DT-VD
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 17:21:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uXRNI-0004r3-L9
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 17:21:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751577703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=sWcmRRvcIJlCcFClGfc15m4V+pyXLQ693ZY86nbrKzA=;
 b=GxQzzgCaaDPf24oReAof5RCpmmj4waMdHkdSWJtjesqvckixMyK2V9KVC6/6Xwtd3qS7+4
 kDGmcJG/2RIhY1OtJjVPpYt7JYO8/igZSMp/Y4rURJgj0AErVzuKm6pn7rtBzp4V3BjlS2
 /EUKzAkevsJEOh55PVKgIduyMQA6G3E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-2llysxEwPb25p10aYrUgdw-1; Thu, 03 Jul 2025 17:21:41 -0400
X-MC-Unique: 2llysxEwPb25p10aYrUgdw-1
X-Mimecast-MFC-AGG-ID: 2llysxEwPb25p10aYrUgdw_1751577700
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-451d30992bcso1600575e9.2
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 14:21:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751577700; x=1752182500;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sWcmRRvcIJlCcFClGfc15m4V+pyXLQ693ZY86nbrKzA=;
 b=dMcA2dfI6I4O6BpnXly+dYpgrSAgAP572y8MSYYtwXvhCezKyedQL6Irkc+6TW2sOO
 GK9O+VpJiC7zyNsFH931dWjwXSNjrOXwOCQOEAZ0ABZ5WU2B49rWypG0NcJVnAP899Ao
 pkPe+LlxCIvDGdOX8eMt7IsdOmji7r9avrVd24UDf3YMPECfa7ppds+TYPfG8CUbOPER
 zPd9W5jlR9L+5RqGkvJ4n43ndOrSzWgW+QxsLziv48BW++aKt2macetmu4g8CcuQxq8O
 +mtm1pt//1DGbUb55Trg/jMkJVHAZh+USsSTbWgURJX7o/HtMtSlS39WDoUWGolh3IEf
 Areg==
X-Gm-Message-State: AOJu0YzCudt7VLDxFJNkmGG/e0Jolk4IuA49vS95VmL0N/+Eg/acsMhu
 /K/xlwVGY1sKnISCOJn1iZmr7kNKUDZhJSMcqD1/2nmDnxLyz1wfK5GBIla4K7cHE0vE4hxI8/G
 DISQpPn2BpYlzr7uZmMRg7tobydxzHRYJqU1h4KgFdzghz3bvTp9bWmrc
X-Gm-Gg: ASbGncv52sFqk4pRC69NmN7t58sKBPaxk+NHmE7UWCuYagLD0IEA+/WLMdsFkoO91es
 5ye1f8juXqmA5rUT6fSooOSNYL+C0+WqYG1TXIsCBqFNi1MHrirhcFgAriUOUfChIyyc2qTjhoH
 Q4t3ALvGPhBPNdNEASb1J1/JtHTlX/rscQdGxJeaY0cNF+AqAsNA5yOjY5gpSG6WDwTx3IlZ4km
 ox3WFjThetdsY/R+JUJWl6C8/OzLaHFAXW6uT5DfIkHv0fnEu51RpBtFKVlGBHFbtiSXHnVE+zn
 Bxm4dASYQ03mNF3QgRSdujJcx/WVZn6MuBl4cvMyoiIosstjvDK3M7shj2Xk
X-Received: by 2002:a5d:6f16:0:b0:3a4:db49:94aa with SMTP id
 ffacd0b85a97d-3b1feb84c39mr7586926f8f.21.1751577700371; 
 Thu, 03 Jul 2025 14:21:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqzUdscVcTiet/RyVoVHPPodha+/IMdsjDME3BdckdWHVegRxVkd/3feXMjEeDoI9lKOurkA==
X-Received: by 2002:a5d:6f16:0:b0:3a4:db49:94aa with SMTP id
 ffacd0b85a97d-3b1feb84c39mr7586902f8f.21.1751577699949; 
 Thu, 03 Jul 2025 14:21:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b47030b9desm733635f8f.19.2025.07.03.14.21.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Jul 2025 14:21:39 -0700 (PDT)
Message-ID: <d588c137-423a-4609-b5b5-66f6f135b12a@redhat.com>
Date: Thu, 3 Jul 2025 23:21:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 20/38] migration: close kvm after cpr
To: Peter Xu <peterx@redhat.com>, Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
 <1749569991-25171-21-git-send-email-steven.sistare@oracle.com>
 <9dfc0dae-f048-4d41-9b6e-02b6e7dbc215@oracle.com> <aGVYD1GkOC-LuI1T@x1.local>
 <a0487a01-41de-4997-860c-bc555a295643@oracle.com> <aGbd0IgvtiR4EkoH@x1.local>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <aGbd0IgvtiR4EkoH@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 7/3/25 21:45, Peter Xu wrote:
> On Wed, Jul 02, 2025 at 03:41:08PM -0400, Steven Sistare wrote:
>> The irq producer is not closed, but it is detached from the kvm consumer.
>> It's eventfd is preserved in new QEMU, and interrupts that arrive during
>> transition are pended there.
> 
> Ah I see, looks reasonable.
> 
> So can I understand the core issue here is about the irq consumer /
> provider updates are atomic, meanwhile there's always the fallback paths
> ready, so before / after the update the irq won't get lost?
> 
> E.g. in Post-Interrupt context of Intel's, the irte will be updated
> atomically for these VFIO irqs, so that either it'll keep using the fast
> path (provided by the irqbypass mechanism), or slow path (eventfd_signal),
> so it's free of any kind of race that irq could trigger?
> 
> I saw that there's already a new version and Cedric queued it.  If possible
> add some explanation into commit message, either when repost, or when
> merge, would be nice, on explaning irq won't get lost.
yes.

Steve, just resend the patch. I will update the vfio queue.
Or we can address that with a follow up patch before QEMU 10.1
is released.

Thanks,

C.



