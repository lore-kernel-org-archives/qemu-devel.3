Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 871D4CEFC20
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 15:04:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syBkt-0004K4-3L; Tue, 08 Oct 2024 11:04:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1syBkp-0004JR-IP
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 11:04:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1syBkn-0005tV-Ka
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 11:04:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728399836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qCLswsaCDmO6lNcN8llSnqr8LWUc01OAPvL2dQ+YGhQ=;
 b=TagTa0MuA7zvFsQi7CFc+yJcwnJ+FAHfRocov1c0DeYedwNV82f1PuGm3JNp51YQ2JLQmN
 14QkyFvD1MXmgml97MK/VkwnU1LG3MtdZyTe4XH8O55zeJcqB17/xTAaFO22XLg9xSUoqy
 D8sNfOaimdzYHVU8W3lhrpuWdh6z91M=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-WpzKRZFoM2SiLRsqQTPxzQ-1; Tue, 08 Oct 2024 11:03:55 -0400
X-MC-Unique: WpzKRZFoM2SiLRsqQTPxzQ-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-45d94168de2so121310671cf.2
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 08:03:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728399834; x=1729004634;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qCLswsaCDmO6lNcN8llSnqr8LWUc01OAPvL2dQ+YGhQ=;
 b=dKiy4ysYR1o0W7SjNV3+4JshPYmkLEuCvNBJnNe0WpKpyImKVi3iw9P2KDq7rkIaoB
 sYR9eebufxoD6sbgUH1SifZrRp6p7kE/sEeTV5baDenjhnVyw3QSNFg702iJkzvxooZ7
 uJt45M8ILdhkhB5ynRatUyTsdeAJ6n0FaHbtgSzdkOlWJ82Ondw2DkKiwELDqi8hAEI/
 Q/CKvNtjo3aJs/o/dfSJHP1+aBvoUa1r9HXH6R2BBSpksbADo9Dzmd0G/VAqW5i+M/oh
 HivwhB2ZdAbt2AqUFbNDw3Q9t1gf24t7DO7+LIVWldqmRMus3V8ryPQjhlYZr8u5qvf6
 IOwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBQpXApd3heXvjKuOvuYMB1w2Smo3UL/X+ANuZpnHZNmM0+leJ0uJaV+gM/JfmlAVTDyzfYYeWk2yZ@nongnu.org
X-Gm-Message-State: AOJu0YzSk/AVNRUyyYLd4Mrk6cxCK8Uy6E1XGfsHuU+u/I4Y8sfWFW6m
 eW/VuMtYJk6vV2PlmlxuRq6GKwZpF9Qz/sKHT3P2gbYTuxvajRpfi7A+8mfSCkC/NNAB/MAJdZZ
 iGMBi6atTZlJRQRU+w/pIOPSX2f/mKd/s2yf6aU7o6zQ5QHAXOS1w
X-Received: by 2002:a05:622a:130a:b0:45c:a613:65b7 with SMTP id
 d75a77b69052e-45d9ba2c34dmr240151281cf.11.1728399834385; 
 Tue, 08 Oct 2024 08:03:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHE4RoXKcuGpvofMzYigpOZtfF6/WQbv3oTOQX+wbAEZsaXG9Ud/QChsXlO/qcjUHupsUhIYA==
X-Received: by 2002:a05:622a:130a:b0:45c:a613:65b7 with SMTP id
 d75a77b69052e-45d9ba2c34dmr240150951cf.11.1728399834021; 
 Tue, 08 Oct 2024 08:03:54 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cbc7ecde8esm336016d6.105.2024.10.08.08.03.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 08:03:53 -0700 (PDT)
Date: Tue, 8 Oct 2024 11:03:51 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Shivam Kumar <shivam.kumar1@nutanix.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] Use multifd state to determine if multifd cleanup is
 needed
Message-ID: <ZwVJ16JDW_U6fPeo@x1n>
References: <20241007154451.107007-1-shivam.kumar1@nutanix.com>
 <ZwQLzf8mGHCr1Itg@x1n> <87h69mu164.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87h69mu164.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Oct 08, 2024 at 11:20:03AM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Mon, Oct 07, 2024 at 03:44:51PM +0000, Shivam Kumar wrote:
> >> If the client calls the QMP command to reset the migration
> >> capabilities after the migration status is set to failed or cancelled
> >
> > Is cancelled ok?
> >
> > Asked because I think migrate_fd_cleanup() should still be in CANCELLING
> > stage there, so no one can disable multifd capability before that, it
> > should fail the QMP command.
> >
> > But FAILED indeed looks problematic.
> >
> > IIUC it's not only to multifd alone - is it a race condition that
> > migrate_fd_cleanup() can be invoked without migration_is_running() keeps
> > being true?  Then I wonder what happens if a concurrent QMP "migrate"
> > happens together with migrate_fd_cleanup(), even with multifd always off.
> >
> > Do we perhaps need to cleanup everything before the state changes to
> > FAILED?
> >
> 
> Should we make CANCELLED the only terminal state aside from COMPLETED?
> So migrate_fd_cleanup would set CANCELLED whenever it sees either
> CANCELLING or FAILED.

I think that may be a major ABI change that can be risky, as we normally
see CANCELLED to be user's choice.

If we really want an ABI change, we could also introduce FAILING too, but I
wonder what I replied in the other email could work without any ABI change,
but close the gap on this race.

-- 
Peter Xu


