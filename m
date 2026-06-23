Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2577CDB470
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 17:02:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc4W6-0001JM-VX; Tue, 23 Jun 2026 13:02:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <utsingh@redhat.com>)
 id 1wc4Vd-0001Hn-OY
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 13:02:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <utsingh@redhat.com>)
 id 1wc4Vb-0002hm-K8
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 13:02:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782234116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+EO0WDaype3uf2WrNllNx5T1AGXJ5HDEiTq5O2QbqU8=;
 b=ZBak8fyEIGttrc0yXGtHkiN8mGXtJeM1lBx01GcA2b3JzA1AM6xfwXBs1Oz2rjTeSUETGw
 qQME9UNL4iZEErrH/8Ndp+z7eFXtQFJ6J/z8Gsel2Tn6FGy9e0GxAcCOI5SW3nL6aJigxj
 1dCQTm42FN1OdYg/KAwfVXLodtKRgXI=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-wZ7lCp2kM8e7vqW9-2Ulmg-1; Tue, 23 Jun 2026 13:01:54 -0400
X-MC-Unique: wZ7lCp2kM8e7vqW9-2Ulmg-1
X-Mimecast-MFC-AGG-ID: wZ7lCp2kM8e7vqW9-2Ulmg_1782234114
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-84531eaf8a8so196746b3a.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 10:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782234114; x=1782838914; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+EO0WDaype3uf2WrNllNx5T1AGXJ5HDEiTq5O2QbqU8=;
 b=IRMEopXucTv4PlykzKA25rB/DBqKERAOebXqSwes4pMixa3W/M9tbDytoFw9ZNxM0Z
 u3KTiChspWy9lgypT+QCZGqLkZ69+NfhNdDHNp1vrnKaXExA6lI/73iEsc4fr3YUvJ3P
 NRuWzcILYlkO6FKAFpgBcCMQUJppbAAg+EXB5B5oWai5YTgHAQ5I8INQ53MOmWVeNKXd
 rDg+5RIQRReY3VjXUvy7plbgRB9QpKcvvWHtNDflb6AIMhdR6vRXdwN1ay1NRjo1lIbV
 h0YhX0omi5gpE/DV1Kll+vZqYGWpkTGPsqtXfMO5D0xuajccF6Mqy4izV8L+u4HcN7XM
 XlDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782234114; x=1782838914;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+EO0WDaype3uf2WrNllNx5T1AGXJ5HDEiTq5O2QbqU8=;
 b=XMA4m5Jlit8jYIdVu3507pu/WFIF4r1lD/gMB1S6Z2pV0M5NK5ajCaTbOG7K+x7R1E
 NMQfkkRHp9fC6AK7/ye3espjJINXfPTyPiiHZzDlyBIhkegcbrfLwsLDieykPVPg2WNf
 ksgPU6ttiWa/FOu415t0cgRqRLMtPuxkT0XO9EgOYwqK8dZtE8vDUzfq3xcgCSHoGTQp
 vvlIJRDABZgP25WMoVYz7XYZ+/JjnLLfZ4Y20njJopPJe81yMaZj0Nc4QbcJAk0nZS7h
 WJZgs2Rtvn8lnzIaGdD5/RhS4Ll8v3XNrXpQiccm4oyOFc0qNPELSw1hSk9tcYW3OvbO
 QDaA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+sceGXNcx+dtylO7ux+If9GTWBZ6Lg/EEvskOtrS5U1mRUkpkek7SSEF+HNjUiHfb1ShEn/1I/Jave@nongnu.org
X-Gm-Message-State: AOJu0YxV3Ao2aWCZgOlPPboYLLCEBA/tWrluNQ1snDC1Zg+KdwbZHYmo
 Pxve2YgCMQosAysrlQoIguZ9Ew90M+ksnjUYjQI5vrrdrMUJ5Dq2eV52g48yF+7H+LX65huynaH
 /FjmVCq1ZjalVeloDaX+ujvVOhVquNa9AUztYEEQBtybGY5/1OHrAXuY=
X-Gm-Gg: AfdE7cnQkFbV+iH4vvLVPnk00EtEy0C2WTPxpwwzYmMgSZevQ1Mu9B0DZSfyYKWScui
 9+aZOvK8iR4nQW16p03F8tfCjqhjsHegMTHIgoHN332+PwHgmhwUS29HN9Eg7750Je69d/WdUFm
 bedLsmGm7T/QFWRyqCjIxeGZfqcOT7/iFZrsLZZanuf8ZcIhs6cYCZR+fmKitApGPBMhzn9cZ4Y
 g7E8E5iBFw7/1fLZMWmkAgK3Dg8wD3jkdsin6Nt8uKKXNIfsTKa2wM+jdircNWECsZE+hqxtEtS
 tth5KITHe8f8VMPG6+0bN3fAW3dmXV9t/zwp3S0Egj9TNEoR7HirCDfWPwY+xEsgrp7mj/qeNSd
 5FUDeMNcA1nSRzI7NZG3h39tcZOj7aLW02HdyTQ0F/i3A6FZOPkZV
X-Received: by 2002:a05:6a00:cc3:b0:842:614e:cc8a with SMTP id
 d2e1a72fcca58-845970ac7b1mr4173723b3a.28.1782234113454; 
 Tue, 23 Jun 2026 10:01:53 -0700 (PDT)
X-Received: by 2002:a05:6a00:cc3:b0:842:614e:cc8a with SMTP id
 d2e1a72fcca58-845970ac7b1mr4173613b3a.28.1782234112585; 
 Tue, 23 Jun 2026 10:01:52 -0700 (PDT)
Received: from utsingh-thinkpadx1carbongen12.bengluru.csb
 ([2405:201:d019:c162:22c9:3093:86cf:366d])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84564d6c2d9sm16491785b3a.6.2026.06.23.10.01.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 10:01:52 -0700 (PDT)
Date: Tue, 23 Jun 2026 22:31:45 +0530
From: Utkarsh Singh <utsingh@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Maurizio Lombardi <mlombard@redhat.com>,
 John Meneghini <jmeneghi@redhat.com>
Subject: Re: [PATCH] hw/nvme: add user controlled 'vid' property
Message-ID: <ajq7-Y3oZcUu3BJK@utsingh-thinkpadx1carbongen12.bengluru.csb>
References: <20260623131946.46879-1-utsingh@redhat.com>
 <CAFEAcA-nrh63fWvnVSSJExspOw28WkZyn69=YMdb5=ZA8m95uA@mail.gmail.com>
 <ajqdIS-BZeyV3lnA@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ajqdIS-BZeyV3lnA@kbusch-mbp>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=utsingh@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Jun 23, 2026 at 08:50:09AM -0600, Keith Busch wrote:
>On Tue, Jun 23, 2026 at 03:01:12PM +0100, Peter Maydell wrote:
>> Should we also have a "device-id" property here? Being able
>> to set the vendor-ID only seems unnecessarily limited, since
>> PCI IDs are a (vendor,device) tuple.
>
>Yes, the quirks are usually based off the same tuple, so there should be
>a way to set both when that's the justification for the patch.
Will add device-id and rename "vid" to "pci-vendor-id" in v2.
Thanks
>


