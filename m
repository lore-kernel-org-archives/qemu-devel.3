Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC4F3CAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 13:13:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4fZi-0004AJ-Vv; Fri, 03 Oct 2025 09:11:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4fZg-00049o-TT
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 09:11:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4fZX-0005n6-Sg
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 09:11:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759497091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ndgFK4nkW6e4f5TCisbYedjckrtL6iE5swqQlnn7szg=;
 b=KQGsPUm+gZsS7KOLhPH8wKGX0MSdJU3v9eIsVSnJxbAhCfig3VBB/j4/Z4ki0i9dIF2ym9
 ft34w0svtj3gonUCt0zEWjkUxd9MRqMwEE/cTEVY7XdcQrGZcr+P8AEgktqVbxiT7brMyR
 WY3BUtmED9LzaIJGPo6V5dK6jyab1AE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-E6Hz9DG6PjmvOW7MmJ6r0Q-1; Fri, 03 Oct 2025 09:11:26 -0400
X-MC-Unique: E6Hz9DG6PjmvOW7MmJ6r0Q-1
X-Mimecast-MFC-AGG-ID: E6Hz9DG6PjmvOW7MmJ6r0Q_1759497086
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4d77ae03937so59438901cf.3
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 06:11:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759497086; x=1760101886;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ndgFK4nkW6e4f5TCisbYedjckrtL6iE5swqQlnn7szg=;
 b=AWxS8QOqaxVSKwSPNc+KEcHiU22pEMDVm3RZaDx635s56o5cEeQ7A99j3UQP8aDls4
 xxKiWUitLF89sgTdLXbmH+w0+VSgiBAMHMSHbNC2vYhjpl0RafpNAtwyE0stlR7bS1hp
 CtuhhasHW4LeYpnrZKwmzlYZk8lW0OjdMVPFlqsVr763RzFxmSvMhP83puR4h/C7S7vf
 INqlan/sA7IsoXcFG1EA3b7SvCkFz365WcV66IHZP95O1oBBEDaw/8RRUMBLCnK7vB56
 exFDjmDZdev72BVh9JMeGTRcasFmaRCSXxVrgPsMSfr2t2fe0LEIEC7buoxqSr+dUoQf
 XyhQ==
X-Gm-Message-State: AOJu0YwWWd9v5ulPkPnb0CDHUOntibjhNQ5j70pllCvay/xn2noj5oTP
 TSOTuONN3XdZ2lQsheCgn+ANPyDKUeb13cOQ4yPQc4vkL6D8TUC/JaTSBbdMU+wvF2HgLxPxx75
 RfeHAMqMiZrCEmRKZT9k9ea5wb1jBmuKbJeNaxmaN70p+Q6ItWwMgv5U8
X-Gm-Gg: ASbGncugFA7tTVxHCYVkezi1d6TY+8ljuPGNgk1hZr+qOcmOvac1iQjoKthhbmDjKbF
 vKxqmPATuimioGh9yK5zCRAIYtp6fE+XiFUok7E4tcrbgWzw2vLAQwm89uBtgMgb+FMQw4heFxL
 Q28+KKaDmnbxnikBe6eUOxGrvdybo82Nz3T8mPrjXi1TdmjEcCr3L+HZ2pGc/AS7DsVpxKbHMdk
 sqhCIu4XlAjcZqdGLPeQX0jISNdH4JJdaukipfSUKOaP2wiw2y7b6jxnkXOusqlzVXj0YZqEePK
 MeJvFkgilUofQGxB/Ru4wf/AIv+uCwyhGyX8hA==
X-Received: by 2002:ac8:578c:0:b0:4b5:ebe7:ac11 with SMTP id
 d75a77b69052e-4e576af9f57mr37536881cf.67.1759497086132; 
 Fri, 03 Oct 2025 06:11:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyhaTX7Qnbmdc3blEtZqFhSM8WmFj0hpB9NnN9cDc8dfGkH6zXhrGjQfkA2ia/BSkTH1rSsw==
X-Received: by 2002:ac8:578c:0:b0:4b5:ebe7:ac11 with SMTP id
 d75a77b69052e-4e576af9f57mr37536121cf.67.1759497085567; 
 Fri, 03 Oct 2025 06:11:25 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4e55a93fd19sm40345161cf.14.2025.10.03.06.11.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 06:11:25 -0700 (PDT)
Date: Fri, 3 Oct 2025 09:11:23 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Cedric Le Goater <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH V5 00/19] Live update: cpr-exec
Message-ID: <aN_Le6Fuzz1uPUnC@x1.local>
References: <1759332851-370353-1-git-send-email-steven.sistare@oracle.com>
 <aN15cNEwH4HBt7NU@x1.local>
 <c7ae8d4a-05ee-48fe-8edd-77dffecf2c32@oracle.com>
 <aN2JE0D44AdV-qK5@x1.local>
 <b01c7919-43ae-4bc6-97a3-6f739ec1ee34@oracle.com>
 <24c7cf7d-8b7f-4341-8a47-e157c16a7cf4@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <24c7cf7d-8b7f-4341-8a47-e157c16a7cf4@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.467,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Oct 03, 2025 at 07:36:50AM -0400, Steven Sistare wrote:
> Hi Peter, do you need anything more from me at this time?
> AFAIK I have addressed all current issues, with the snippet above, and
> with the new 0001-vfio-cpr-exec-mode.patch attached earlier in this thread.

I got everything. As there's some dependency to Fabiano's pull that already
sent, I'll wait that to land first to send the migration pull.  It's likely
easier for Richard.

It should be early next week.

Thanks,

-- 
Peter Xu


