Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9161CD98F2
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 15:14:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waauu-0007qf-MP; Fri, 19 Jun 2026 11:14:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1waaus-0007pv-G1
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 11:13:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1waauq-0001Qg-Th
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 11:13:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781882034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WY9zXhKzVITuA8MGsWDx4DYJSZbSzt5qLXb4eP7myuY=;
 b=eucRzzTlWOFG/C+0mOnNjTeeKYK/Ad+HaldJ3obqIBoqQ/FvPXFCLO7SrDrixkrKcwVBAP
 6+uYA9XWIIZxWPIakF8wfRe8Iaq0Yds5GQOWlOURgsov+f2taqCd7xmcIG5hm6ohzbiJ1z
 vmpN6VXSvEsJGFiNQob5GXjwxAM83cc=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-2a7mgSTtNCGxdRU4Yjep3g-1; Fri, 19 Jun 2026 11:13:52 -0400
X-MC-Unique: 2a7mgSTtNCGxdRU4Yjep3g-1
X-Mimecast-MFC-AGG-ID: 2a7mgSTtNCGxdRU4Yjep3g_1781882032
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8dcfdbe9da2so59568316d6.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 08:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781882032; x=1782486832; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=WY9zXhKzVITuA8MGsWDx4DYJSZbSzt5qLXb4eP7myuY=;
 b=TsllGiqELucoWIbm5AywZqoTkefRy5+r/Q3IA1zABA7URIr8qamSeJZAjs31CIUeHi
 cdWVv82IMBwAN17tYiGGSOzNKln9WMW7bOIhp6y/jdykrePOBELwsKx4Uze2BL7nbL4G
 cUTlO5tD9R9e7Qu/U3ioF0nIGoCrq4436UK6ISXwaKT+1uvY1dK/KOF8VOCG9woAhzyB
 mJyqluimS5heiVg1MJqaLaXA6A5jnDt26jb/HlkjFkjmLOIipPFDXb7Jh9s5VFpufc9S
 tMu/DlD0qNRzO92cLhaV088w0T+bK6qzSYXwXQmmMISlmzNQx4/d4VzTHIBH3C0E7oev
 QAFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781882032; x=1782486832;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WY9zXhKzVITuA8MGsWDx4DYJSZbSzt5qLXb4eP7myuY=;
 b=oQqDI4WKrLWZl4KxtDNV6e3zj9eFvUTJg8MXjKLb+QWFOp2SuDO9s2gg3B4LjIJvLh
 7yWXqcGjaYsZh40tDoEnq/I+Tb/WR3cNTHmk7meQdjmm1zU3oEGUvH1UnxVqzEvPTJFb
 VhPTeYWaooK/adCJJDEOk6qr6ptP1cjWBcHhB5C/PkYEwCyqPzMuJLYWfd5UpkGmbVcX
 0n/Xwx4ngxd4/RY5qFhmHd/3QA0bTW7klDErPV4o825PGYzXnD4cTTYhDhUzFGxD5mCP
 BYpCnmPlVtVI72la2CV6yHwjxRiyzcPn97s76c2YFhB6w4um+fqlAaSVyp1y5T2PxKz4
 wr/g==
X-Gm-Message-State: AOJu0Yzwk+dlG6p/D+qRqLLLWuI5Kzbo9WsnNothXk4pjPkecr0dalFL
 A6p7wcm/0VLEig0aLbhGdfK5QoLjE3T7HD1Wq6AQhvo7tYzq8xOPcYMyIJ0BoKe+Ek9L/MjW7Oa
 VgznYkqXqsLHECASp+um+YQuOjlILyJFZDHASXL1cqkhdaLhhOM0NrytU
X-Gm-Gg: AfdE7cmY9/FrHbVW5Jv7sx+fTSBFWTFPmuvl4ArDYEygApzWUIkh8P1vKc49eGPWsfO
 YuxlfJLjzebOevArJx4qd4CIWpQmFgZguzL69NccP9NIThyLffl82gKx2K/BsmjbZCHF/vapO2A
 EadI+E5/2d4MtV/qKrYaaU3kp6uQr+JyutSwrpUy75NSBHQiAg/BVicPeA2+Servugq7uK864xd
 UeGzCaB23leLX5n1cUKGWkj1BUHOzSVyClccniVQZ0A3bLdpck8EDy3xEcfSpFRadSkpj8AfeY2
 XuFtahW7kUnQ2eivultoIKwwxA+IynSlce2CA/ib7sttbkjTPtV9g8azYel4lk5o0eW60eFmyjm
 qxGJO
X-Received: by 2002:a05:622a:4c0a:b0:517:6afc:b644 with SMTP id
 d75a77b69052e-519e4db674amr55150331cf.47.1781882031965; 
 Fri, 19 Jun 2026 08:13:51 -0700 (PDT)
X-Received: by 2002:a05:622a:4c0a:b0:517:6afc:b644 with SMTP id
 d75a77b69052e-519e4db674amr55149761cf.47.1781882031416; 
 Fri, 19 Jun 2026 08:13:51 -0700 (PDT)
Received: from x1.local ([174.91.117.157]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-519e60ede74sm22190141cf.25.2026.06.19.08.13.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 08:13:50 -0700 (PDT)
Date: Fri, 19 Jun 2026 11:13:39 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 qemu-rust@nongnu.org, Alex Williamson <alex@shazbot.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Fabiano Rosas <farosas@suse.de>, Mark Kanda <mark.kanda@oracle.com>,
 Ben Chaney <bchaney@akamai.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Zhao Liu <zhao1.liu@intel.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: Re: [PATCH v5 00/12] Make RamDiscardManager work with multiple
 sources & virtio-mem
Message-ID: <ajVco512NDPKDPTr@x1.local>
References: <20260604-rdm5-v5-0-5768e6a0943d@redhat.com>
 <CAJ+F1CKRvSWDOvKC98e_7uyjgJMuXfhOHP83H0s7a=+ZrYxA1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1CKRvSWDOvKC98e_7uyjgJMuXfhOHP83H0s7a=+ZrYxA1g@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jun 19, 2026 at 12:11:48AM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Thu, Jun 4, 2026 at 5:46 PM Marc-André Lureau
> <marcandre.lureau@redhat.com> wrote:
> >
> > Hi,
> >
> > This is an attempt to fix the incompatibility of virtio-mem with confidential
> > VMs. The solution implements what was discussed earlier with D. Hildenbrand:
> > https://patchwork.ozlabs.org/project/qemu-devel/patch/20250407074939.18657-5-chenyi.qiang@intel.com/#3502238
> >
> > The first patches are misc cleanups. Then some code refactoring to have split a
> > manager/source. And finally, the manager learns to deal with multiple sources.
> >
> > This has been tested together with the Linux kernel series from
> > Zhenzhong Duan [1] for TDX guests.
> >
> > (help fix https://issues.redhat.com/browse/RHEL-131968)
> 
> Can the patch 1-11 be queued or are we missing something?
> (RFC patch 12 can be dropped for now)

Likely yes.. one thing to double check with you before I do: We don't need
the kernel series, do we?  Since when unplug, I expect with the truncation
approach that this series proposed, KVM will emit TDH.MEM.PAGE.REMOVE then
unaccept is done (?).

Say, what happens if we run QEMU with this series applied, but without the
kernel series?

What confused me a bit is the dependency of this series v.s. the kernel
one.  It seems to use different approaches, but then I don't understand why
this series was tested with the kernel change.

Thanks,

-- 
Peter Xu


