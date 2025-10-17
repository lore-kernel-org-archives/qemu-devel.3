Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FC66CCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 13:54:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9ksx-0004lc-6e; Fri, 17 Oct 2025 09:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v9ksu-0004kg-7k
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:52:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v9kso-00037L-5L
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:52:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760709152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iQhsQBJSeg7Qg2pC2jnr0EDVDlslsEoDpdATCX8PPXk=;
 b=WStwnRm2TTZzxaDNe4BfyjzWxdSAelBYYIcotsUa6sogC81YUI6ns8sS0u5KJYWz+vdG3r
 y/UBTwXTiNSS/v4O593rN6v5GiV3GOiTAuJMc51rDHTj6xjLxZ14xvf8nDoheSFrDwuwcd
 UC2XE5bCJC8TRr8+TRLXoT5HJEJ8jMY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-x2Iu4b04OfuJRZa_cwifAw-1; Fri, 17 Oct 2025 09:52:31 -0400
X-MC-Unique: x2Iu4b04OfuJRZa_cwifAw-1
X-Mimecast-MFC-AGG-ID: x2Iu4b04OfuJRZa_cwifAw_1760709150
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4256fae4b46so1244735f8f.0
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 06:52:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760709150; x=1761313950;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iQhsQBJSeg7Qg2pC2jnr0EDVDlslsEoDpdATCX8PPXk=;
 b=Q8AQwp0W5P9p7XKOo9eBTy8lpz/orBQl/DDxjibl1yX3+2NMFvwQAOPgYFnL5jb74D
 PfTa7g7VGcGa321rYxMWS0RmUhL1wqZNlHx/VQ7R8FqTnXDqZtj811inhAfMH42DPjs4
 xwd/w/yMArwCn59AiYXNmSqOe8e1XkANTZxL0MVjnGL04uZsAubB5Pmm9PLBnFr4fo4v
 bSp9jhWsOt0herIzunuXy+luIZLcub3FJ9+fPZaS4sdSLSeTIxNbZnEYCAfovz3uSG6k
 SuZCndPVrGIXfcUJbtKIHF9cFgjJvkHvOmZbpnDWTORAQfosCoxoD3BkdGmhfPX4TJ6L
 qNvw==
X-Gm-Message-State: AOJu0YxJe78DvGOAgyPHQI2cOPD/3n9osk0hbcUYetA/g68+Rp0jFdZz
 GbiF0WWc7x8y/+QhNIpHoY1ifXCl9qDR1SOy+bR37/wqKUSpgvRYDm/g2vftQfgNQ7ro6hyxtgJ
 h1V5Pv1nQWcckaX/9ERe9hj3qwVYbeJaZ+2PuzbLD3a0KzaWQoyaR4OC7
X-Gm-Gg: ASbGncsn2jgv+g+oXlkOwuyM5yv4fjzKe4+Nc59zvyZ1V8bQAaLKbGr0H6sczgqfel9
 rfgbsgODERk5cslgzlz94+W5K0Vh60UTnm9e5DiPc/TdQOSI26X+uhsD99U2VWxblwppcWLTW03
 FAKxr7/aCq9ihSe69nWEZ6V1aMM1F2S2OwfETUIUmsrXQBVJyhZTS1SHTuZ0qNGZV2CpNXgzCvy
 Lb/A7cgkhHUyYlPkgxwVsCdUpFOUNzselQoCagD40vlWUz+3K/fgTxbOJs2rVxBMlzBDnQf988g
 wbaStCZVlTV6b3TBbQ1f6H2WSZ4Q2Bpb0Z/jjv9gE2BokyB9T86hAMBkniHPI+cC
X-Received: by 2002:a05:6000:24c6:b0:427:928:787f with SMTP id
 ffacd0b85a97d-427092879c8mr922458f8f.21.1760709149640; 
 Fri, 17 Oct 2025 06:52:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVBPLcl/Rq1/TEU+9oQSTZwnXrWJ9QHP7ayLmkUAzRAkCXP+bfJPbxORpTMQ88Bd/C+sO65g==
X-Received: by 2002:a05:6000:24c6:b0:427:928:787f with SMTP id
 ffacd0b85a97d-427092879c8mr922420f8f.21.1760709149031; 
 Fri, 17 Oct 2025 06:52:29 -0700 (PDT)
Received: from redhat.com ([31.187.78.207]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42707b482b3sm3729718f8f.50.2025.10.17.06.52.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 06:52:28 -0700 (PDT)
Date: Fri, 17 Oct 2025 09:52:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 hi@alyssa.is, david@redhat.com, jasowang@redhat.com,
 dbassey@redhat.com, stevensd@chromium.org,
 Stefano Garzarella <sgarzare@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, slp@redhat.com,
 manos.pitsidianakis@linaro.org, Albert Esteve <aesteve@redhat.com>
Subject: Re: [PATCH v10 0/7] vhost-user: Add SHMEM_MAP/UNMAP requests
Message-ID: <20251017095217-mutt-send-email-mst@kernel.org>
References: <20251016143827.1850397-1-aesteve@redhat.com>
 <20251016150544.GA1174075@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016150544.GA1174075@fedora>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Oct 16, 2025 at 11:05:44AM -0400, Stefan Hajnoczi wrote:
> On Thu, Oct 16, 2025 at 04:38:20PM +0200, Albert Esteve wrote:
> > v9->v10
> > - Fix transaction_commit invoked without transaction_begin
> >   on vhost_user_backend_handle_shmem_map() early errors
> > - Removed fd tracking on VirtioSharedMemoryMapping, it
> >   is handled by the RAMBlock
> > - Reject invalid BAR configurations when VIRTIO Shared Memory
> >   Regions are in use by vhost-user-test-device
> 
> Hi Michael,
> I have finished reviewing this series. If no one else has comments then
> it can be considered for merging through your VIRTIO/vhost tree.
> 
> Thanks,
> Stefan

will do, thanks!


