Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E17E4CFB451
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 18:12:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxsDO-0001cc-KP; Mon, 07 Oct 2024 14:12:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sxsDM-0001cH-3e
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 14:12:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sxsDK-00032W-MG
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 14:12:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728324728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FeDVs9i2iJCfoKtsboR/ROCJfQcqHnzaTfF5Mdilv+Q=;
 b=Qplpu6UeQ99T3umyyYUJhUSr2fZRoOuqbTsslnuTgE+KRoFF+b4rwnftFZns9n76hknSRA
 i/Iec0iXEU9VKbjSOchXycEeBdRS/M2ikO0CfSKAFsZjaFud8EBrz3KPXkrPBPvsZf9LjM
 qtdHDnK51a5Oph25F6td75PECIKoQb0=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-zuytq_CZO2ydZHKflUH_aQ-1; Mon, 07 Oct 2024 14:12:07 -0400
X-MC-Unique: zuytq_CZO2ydZHKflUH_aQ-1
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-82cdc7b7debso419995739f.3
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 11:12:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728324727; x=1728929527;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FeDVs9i2iJCfoKtsboR/ROCJfQcqHnzaTfF5Mdilv+Q=;
 b=CBq0T+vfiXtUXptvM/HqB/6wVhqf/E3BYO5ayj6f09yfnkF0bdqK1DhHSz82zqBtYK
 0k8xXTdmTXeTl+ayUiViowuIUl+0brXO1xnAYopKamWnMDzm7VdqOdAHfEkC9LqlLYFd
 mAP1CMxTKVeKASp/wvSRqTY3Ovt+xJzp3lG8EwA6JTZuHbTIwA0CEv0E2BdZQtvJ8iP6
 MS2KOdXwV0h+Q9p0HfZDVElzgAseohnxXYTeEL8wLDYHiy84lXJJ6XFHmrl7hyoFNl4L
 BCX08EEEWu2gFwGX8IBS905j3YDzRfDLlgMQMQx1GoW3Bcvx76vGhAGDocBGzqtosP9/
 YN+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPl7D+7FDM7f1+bT0LYYtehkEaPG7PTEtdsKX259fC8LPcpHskShmoAE22xE22U024y7tAe4YtyQk1@nongnu.org
X-Gm-Message-State: AOJu0YypTqcnYURRrjBk3itziPTotq9YDerrig6o8NhkbcOEjlC9vCAP
 Qp7PTjWPmqSCBChSBJxJKH82a1H4NAvkWjWUaJHKN+6RNcUQ7Aqv7J/2GYoDZ/i86Y85D436PBi
 bR38E+BE1OpFOqY3heF58LtYUZ3RPvEZgmi+H7z43tT67UVD4+dRn
X-Received: by 2002:a05:6602:485:b0:82a:23b4:4c90 with SMTP id
 ca18e2360f4ac-834f7d06eb2mr1155787539f.1.1728324726898; 
 Mon, 07 Oct 2024 11:12:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlQ1HyV/jtkEVzqxfYYg8w293xr9frviH/R7VCUEDHSSQoVJZRFby/nDGiSovM4o9ED6rPUQ==
X-Received: by 2002:a05:6602:485:b0:82a:23b4:4c90 with SMTP id
 ca18e2360f4ac-834f7d06eb2mr1155784639f.1.1728324726531; 
 Mon, 07 Oct 2024 11:12:06 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4db797d43dcsm998001173.37.2024.10.07.11.12.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2024 11:12:05 -0700 (PDT)
Date: Mon, 7 Oct 2024 14:12:03 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V2 07/13] migration: SCM_RIGHTS for QEMUFile
Message-ID: <ZwQkc1XzmmjQ7SGL@x1n>
References: <1727725244-105198-1-git-send-email-steven.sistare@oracle.com>
 <1727725244-105198-8-git-send-email-steven.sistare@oracle.com>
 <ZwQG_dvmTFFA2Xom@x1n> <ZwQN2YoMWNTMdop3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZwQN2YoMWNTMdop3@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Oct 07, 2024 at 05:35:37PM +0100, Daniel P. Berrangé wrote:
> See 'man 7 unix':
> 
> [quote]
>    At  least  one  byte  of real data should be sent when
>    sending ancillary data.  On Linux, this is required to
>    successfully send ancillary data over  a  UNIX  domain
>    stream  socket.   When  sending  ancillary data over a
>    UNIX domain datagram socket, it is  not  necessary  on
>    Linux  to  send  any accompanying real data.  However,
>    portable applications should also include at least one
>    byte of real data when sending ancillary data  over  a
>    datagram socket.
> [/quote]
> 
> So if your protocol doesn't already have a convenient bit of real data to
> attach the SCM_RIGHTS data to, it is common practice to send a single dummy
> data byte that is discarded.

Ah OK, thanks.  Then maybe we can still consider dropping the initial four
bytes for fd migrations; I left the other comment in the next patch.

-- 
Peter Xu


