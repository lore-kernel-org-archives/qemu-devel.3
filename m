Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C397E77170
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 19:27:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIv1a-0001TE-OP; Wed, 04 Dec 2024 14:27:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tIv1Z-0001Sz-2e
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 14:27:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tIv1X-0004cY-Nc
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 14:27:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733340417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TLn57UfIpy0CQDMIe75pvVLz502cziexUrI5Nzh58gM=;
 b=OSs0/PpzkJqt/y9MvhGwpzaTBqWvpNSog8EaC8jCMCA8U7LwgigcS39CiPOZkI17XamTPJ
 oStma8+srI0ZnKB5WQ8PVsCDdTtZyfABZojhpeUuqPBJv22IOsqLidVMbZtL2lLfP5m7M6
 7OhJ7I0u7lilBwvtolVit7BRB67ggX4=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-Kuxormk1OfagMoRyJjWznQ-1; Wed, 04 Dec 2024 14:26:52 -0500
X-MC-Unique: Kuxormk1OfagMoRyJjWznQ-1
X-Mimecast-MFC-AGG-ID: Kuxormk1OfagMoRyJjWznQ
Received: by mail-il1-f200.google.com with SMTP id
 e9e14a558f8ab-3a778ce76fbso620695ab.1
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 11:26:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733340412; x=1733945212;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TLn57UfIpy0CQDMIe75pvVLz502cziexUrI5Nzh58gM=;
 b=KwpTD2w8kNJfzhy1XCIRsgCVS6AcJSHUbvMBxvzu/BIZV9FAHORPh10eumhI/1nHsz
 oqGyLkYM/ahug+y4mEForUsAtk6+2T0sDkqz5SyBmWtYW/wg017FTXSc5F7ih0BVTJcU
 DhkUdGAjXhU0/mL8BTaq9lbvsJN4n+TX60nqZ4PcxJd1Ghm3tYWmICDytb8sWhvum1f/
 0whdJ5lVEEDHOhoWG0HF8AKxC1XYaeymB/UcaWIZ/yXybU046Rk5u7cbgq/4ivg6ffiN
 9X+tLPFWtOzgfSI2uPt7s/6hwAV5e9TFcTm43xf14Nuaypww7Kx7q+HWVaYdlD7uzCVR
 zDfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYxh6iBUMcCUKMgs3cBmq00Yu6bC+Kz+xKK2l5egPanZPDlwb98gt0a3RVBBBfRcCQZZFty73Yv55W@nongnu.org
X-Gm-Message-State: AOJu0Yzso096a4Rqqw4UcD4yVYkp4azobPNWypJIC9jENCA26JMJSSHk
 bWTyPfEJ6oAGWiL8t8x9rVsRtuTLcnFGen6+E/o6xddoDvzyVr73RyCllYMU4Er93Qb0mzcc6vb
 hK7UMVAG7w0wW/sp8rhzI92y0+7B9rHLwmTQ7FlcZYDk3cByMBg2w
X-Gm-Gg: ASbGnct9gIWdvzWYQlbQIUc3wE13KHWYE7V8fSnBN2kPk1rNVggK2q00RIXgKuQaq1U
 pVc+dDRgSp8y0kOcrFdLjQAT6apC2DyoE7fDaodVx3OanVrEiG/YfeWVCUrDnspHur3e8ODZ1/u
 GdJC7lHy08scJMVMHBzGSEkQDpbO9QUo/f3LCGR8QdkbSdT8iMjRHrlSP65EHqzw5zjcZVW0lGL
 dSHAg4URNm9YkqVgodLPrjL3YpzEtHmrD+HO0RwVKIxM8R74pol083CmZu6gy85023rICnPRUj4
 w9OL7rxNfJg=
X-Received: by 2002:a92:ca45:0:b0:3a7:c072:c69a with SMTP id
 e9e14a558f8ab-3a7f9a25dcfmr114274715ab.3.1733340411848; 
 Wed, 04 Dec 2024 11:26:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG1xBPswLvv8XkvKwYvrVSQ8f3nGQ//nj8GdIjjGMZ1hzA0p9oy0w2AA1Gw0nZ3+prt3kiusQ==
X-Received: by 2002:a92:ca45:0:b0:3a7:c072:c69a with SMTP id
 e9e14a558f8ab-3a7f9a25dcfmr114274535ab.3.1733340411616; 
 Wed, 04 Dec 2024 11:26:51 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e230e755a7sm3165737173.124.2024.12.04.11.26.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2024 11:26:51 -0800 (PST)
Date: Wed, 4 Dec 2024 14:26:49 -0500
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 03/24] thread-pool: Rename AIO pool functions to
 *_aio() and data types to *Aio
Message-ID: <Z1Cs-ejsnSqRxAQV@x1n>
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <ea3e65080c00cebdc95dad8b68070709c3607e79.1731773021.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ea3e65080c00cebdc95dad8b68070709c3607e79.1731773021.git.maciej.szmigiero@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Sun, Nov 17, 2024 at 08:19:58PM +0100, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> These names conflict with ones used by future generic thread pool
> equivalents.
> Generic names should belong to the generic pool type, not specific (AIO)
> type.
> 
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


