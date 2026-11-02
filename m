Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2611608441B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 17:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VlVagXCx;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=GalYYdOm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNveA-0001BF-K4; Mon, 02 Nov 2026 12:16:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xNvdn-00018A-Vc
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 12:16:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xNvdl-00070a-OK
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 12:16:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793639771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R1cbDGwr8PmyHixE6Fyn+pRIVCcQjoctPl2TZJMnV+w=;
 b=VlVagXCxi3MA1upfvnRI+Z2axt3TNNMcSq/LoHosUZC2xG7GNoIEYmYiJ1WqezO00nLK4N
 /4mXMjUxZXdWrIlUn52s4UtHFYDN9W3/hVG6PeB7wnXQsYZLGiwVt4c+0rQVybfPHoF9yz
 nuxHkIFCTAb1pzDkk8RkyRyeMo4ZPYA=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-yCEyhWkANuGZLlwIuYKW_Q-1; Mon, 02 Nov 2026 12:16:09 -0500
X-MC-Unique: yCEyhWkANuGZLlwIuYKW_Q-1
X-Mimecast-MFC-AGG-ID: yCEyhWkANuGZLlwIuYKW_Q_1793639769
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-88322409239so57309027b3.1
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 09:16:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793639769; cv=none;
 d=google.com; s=arc-20260327;
 b=SsTPyYtqM8nAJowONfbsR+tMeAZc8IpPl/xmO9p5ed4YkYGcM4Q/OlI29F0BiqUo05
 LYeXPUrzuSmXSobHGV39Q4x5NMgb5wosMCXrw+IX+E61uCovOpP62UX2JfhU4n8yQRFj
 FvQNq3X6HJ+MqSIp8qsKy3D15Y2/udVtn0/LkBdigAY+yyXWKV+NBmUFmTih+0ZBpNbl
 OY9Y3UBx70vqjdJEK7Y3+Pyx5jXweMW1W69Nfd1hNVDBdGNtN04R67Yi4Ave1wcv3j4O
 2ffI2CiT4pJNqPjdgRhEelbiLjn+9MGZkUnhCOBocgVhmO7UIMqkjqVDKytG+X9Hb5hy
 m2xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=R1cbDGwr8PmyHixE6Fyn+pRIVCcQjoctPl2TZJMnV+w=;
 fh=CE0FkwzGJ8LY89xVhD74poZ1QR+EhyA9dPmSQRNKqmM=;
 b=nFAGcLUMb/Ppd5O8zS6AW5tRXmMUmJgxI6jUuOpskO6kDuagRLiC77BHRoi/+YfvMr
 arH1DN4LWeiwGH1Aq78iWJUdtEb2Xor+cv0lqv3/bPcnge2LdCUuqHiTDCSXIIDg5ko+
 BSIyB9v54WwxQAVpL7EnMYosjCWkCoHyUBE/chhhRwBJOeYVyNRza1vlyc2L8IuQ6qI6
 SVp/t+scUUsw0SJzgXh5kiE1gvjZEUIDU2KFgbEbKpXAjCACt0RYeQhn0KY06ds1qKEE
 ripQQbwXHy0Bv6x2arYHxoy+UxRV8eGbYJJ6F3KiwuJy5t5j9RTPNpnNCloWLiQI+l/z
 QkGQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793639769; x=1794244569; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=R1cbDGwr8PmyHixE6Fyn+pRIVCcQjoctPl2TZJMnV+w=;
 b=GalYYdOmm79VqtYvnIFdSZ8EPFBpv2aDypVczgbeNPxy5qetRKPJseQOVmxoROnf4k
 mQijHmcUNFzBoqOypMPD+uUA8fnUNZA9HBfYACQH3VWhaG/J9qXnr9GFiL/Ug9cofkD+
 t5NnwCs7gpffo+GSNp31ICHspTKsn3wZqhWZoFBO4kEGkgJbZATlngDt+nyD0HguK6kb
 PMsdtL5orbnk9oU14Tsg4fn+5EUhNmnoZ8D8RuVFmh16/0o94R+1vERTq2qJgP3EWUCf
 7NQ2ucwSSOgeOUQ/Y4AQ43cHl5Ebd9fMNoTytjkghXpxm723SNuvPz1JH1oBaH+UFbMb
 Zjpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793639769; x=1794244569;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=R1cbDGwr8PmyHixE6Fyn+pRIVCcQjoctPl2TZJMnV+w=;
 b=ZL6aU29Hx0sKxanvZ1UVX2DOr+PhaLCTn4iuTuLrRIRlhX1U7jeOkuikXVUBS0T0ah
 MSx9P0yhltJTBA0ZzmcmzQ9xhTka1/PpHp04bEEHj5GU+hwYgbxXpKIo/H3KvbUJWqCL
 qebb3UqzgJnNx6jSI0E8K7LfQisbiA1sT3P4vcxNFDXNAVkxTtEpL28DSOxeJK/DKktd
 GKGIHmZC1tc7BqJ620bR6erdXjVQeJive8ughxfbgYUzbidTj5B7leQuIrueSyh/fFPZ
 //K0iLrSJPHK8BwPWplUUhQ+fnaXca+lUYSvqbkFvM8NjPbSCq6aICITcsF8qbdCkz6g
 mw2w==
X-Forwarded-Encrypted: i=1;
 AKwUvByrat5iVpJCCXq6kKdxDOrdswRTMHra3mJ2+Ww4ae7gIsnLEu1jho7MeHtFzqA437RGeS81BRz4A3H1@nongnu.org
X-Gm-Message-State: APuU4Z8CWCXG3FYMF4TDiTN0WNzZWLwzOFcJfODkdNZyzCXXECNfCFPa
 TX1kY0sfRPVVB9QzyZUfllrWE631U6fgr/qG//xrcHaC0zpRsB/QzDHUVYX/vcixacuJc+d511d
 BfAiOBSgB3Rh5dlbgNwDnTey2T+ioawQSxXxdre/euz6cQ/AglEn1mZ6vCVoa9iRoylMs5h/+Vs
 Zr3rFpuZS28b9IyXRIaGoJF7+bwyv5z30=
X-Gm-Gg: AYBFou2QlrBmX10cc/+rnvkAaXaQPkReD5LL3Zu1ZfRoKsGVM8wKa2DxwaqB1PlJLVY
 TIzbv6xbVatVZtkMvIpM2Rd3JZBQwtkxv+s6gtCRaJ0P+jd4cwdYPP7tQ5ufZ23ollF2M8fpyTv
 7XNkPjIegrCg6lQkhKjVCY7YVxmGFUXuIhqVoDV/ff6ntaNOMMbLdC/e28XCdiOHbZb9UuMln1S
 iLt4hvErsrRM6AB
X-Received: by 2002:a05:690e:4548:10b0:679:b744:a2f7 with SMTP id
 956f58d0204a3-67ba4fb945amr5448574d50.59.1793639768770; 
 Mon, 02 Nov 2026 09:16:08 -0800 (PST)
X-Received: by 2002:a05:690e:4548:10b0:679:b744:a2f7 with SMTP id
 956f58d0204a3-67ba4fb945amr5448558d50.59.1793639768341; Mon, 02 Nov 2026
 09:16:08 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261102134115.282413-1-abhisek.panda1@nutanix.com>
 <468bcc37-699b-45d9-a0dd-63f957ef1af5@virtuozzo.com>
In-Reply-To: <468bcc37-699b-45d9-a0dd-63f957ef1af5@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Date: Mon, 2 Nov 2026 12:15:56 -0500
X-Gm-Features: AclHuK-UROTkGEJtti3G9XrZZd-dfyapX4HH1V__aDa0DvDg4OmHksN8kDMKekE
Message-ID: <CAFn=p-aLhjXJi_TvXTMfkC3NarXbV2+wMzMk+n3VWqqb9co0Ow@mail.gmail.com>
Subject: Re: [PATCH] ahci: Check Bus Master before starting DMA/FIS engines
To: "Denis V. Lunev" <den@virtuozzo.com>
Cc: Abhisek Panda <abhisek.panda1@nutanix.com>, qemu-devel@nongnu.org, 
 qemu-block@nongnu.org, den@openvz.org, andychiu <andychiu@synology.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 2, 2026 at 10:42=E2=80=AFAM Denis V. Lunev <den@virtuozzo.com> =
wrote:
>
> On 11/2/26 14:41, Abhisek Panda wrote:
> > When a Windows guest puts an idle SATA drive into standby, it disables
> > PCI bus mastering on the AHCI controller but fails to clear the port
> > engine bits in the port command register. During post-migration
> > handling, QEMU=E2=80=99s ahci_state_post_load function checks only thes=
e port
> > engine bits to determine whether to start the engines and map the FIS
> > receive buffer (PxFB) and Command List buffer (PxCLB). Because PCI bus
> > mastering is disabled, DMA access to guest memory is blocked.
> > Consequently, the memory mapping requests fail or incorrectly route
> > through bounce buffers instead of direct guest memory, causing the
> > destination QEMU process to abort the migration.
> The fix is right, but on current master the abort is the less common
> outcome. Since 637b0aa139 ("softmmu: Support concurrent bounce
> buffers") each PCI device has its own 4k bounce budget, and a started
> port takes 1024 bytes for the command list plus 256 for the FIS area.
> While the started ports fit into that budget, post_load succeeds with
> lst and res_fis pointing at private zero-filled bounce buffers, and the
> migration completes. When the guest later stops the port, the unmap
> writes those buffers back, i.e. zeros land on PxCLB/PxFB in guest
> memory. Only when the budget is exceeded does post_load fail.
>
> I have checked both on q35 with a qtest: clear bus mastering, migrate,
> re-enable it, stop and restart port 0, issue IDENTIFY. With one disk
> master migrates fine and stopping the port zeroes the whole command
> list and FIS area. With three disks the destination fails with "bad
> FIS receive buffer address". With your patch both cases migrate,
> guest memory stays intact, and the restarted port works.
>
> Please describe both outcomes in the commit message, the silent memory
> corruption is the more important one.
>
> > Starting DMA/FIS engines when bus mastering is disabled might lead to
> > buffer mapping failures or improper bounce buffer allocations. Do not
> > start the engines in the aforementioned scenario. When the guest
> > re-enables bus mastering to access an idle drive, it should reset the
> > port engine, safely allocating the buffers and starting the engines.
> "it should" is what the patch relies on, as nothing restarts the
> engines on a bus master 0->1 transition. Andy's trace in the 2019
> thread shows that Windows 10 does exactly that: it re-enables bus
> mastering, rewrites PxCLB/PxFB, clears and restarts PxCMD and issues a
> COMRESET. Windows 7 does not clear bus mastering at all. Please state
> this instead of "should".
>
> > Reported-by: andychiu <andychiu@synology.com>
> > Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> > Suggested-by: John Snow <jsnow@redhat.com>
> > Link: https://lists.gnu.org/archive/html/qemu-devel/2019-09/msg01544.ht=
ml
> > Signed-off-by: Abhisek Panda <abhisek.panda1@nutanix.com>
> With the commit message updated:
>
> Tested-by: Denis V. Lunev <den@openvz.org>
> Reviewed-by: Denis V. Lunev <den@openvz.org>
>
> Den
>
> P.S. John - will you take this?

My attention is currently pulled very strongly to an in-house project;
If you believe it should be merged I will trust your judgement and I
wouldn't be upset if you merged it.

--js


