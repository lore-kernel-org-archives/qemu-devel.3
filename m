Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2130C83F27
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 16:05:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueFU0-0003GB-HR; Tue, 22 Jul 2025 12:04:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ueEkA-0000OM-HA
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 11:17:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ueEk8-0003cu-6H
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 11:17:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753197442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r4stJ6qTmHPTO55M3a0I58T+8w3Fa+8j8McIc0U1Buw=;
 b=T/sQoY0eYodl6BEEPQ3YZtej0vemNsU1DCGEDdT5eNPeBm9a52wHyMmPs1Os4uUm9TuzuU
 6/jjbiMWx1neYHnNpkkjR4VaxKTndxa3mqBTRo7vmxIf6JuAE+QYlCaxC/fzOFN1eHDAB9
 0xKghnn9iEvu9fYxijaYPTUtvQg/fEI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-424-VViUxlQnP2ORdFEgJo0_3w-1; Tue,
 22 Jul 2025 11:17:19 -0400
X-MC-Unique: VViUxlQnP2ORdFEgJo0_3w-1
X-Mimecast-MFC-AGG-ID: VViUxlQnP2ORdFEgJo0_3w_1753197438
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A0D12197730E; Tue, 22 Jul 2025 15:17:17 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.16])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 293B230001A4; Tue, 22 Jul 2025 15:17:13 +0000 (UTC)
Date: Tue, 22 Jul 2025 17:17:11 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Brian Song <hibriansong@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, armbru@redhat.com, bschubert@ddn.com,
 fam@euphon.net, hreitz@redhat.com
Subject: Re: [PATCH RFC 1/1] block/export: FUSE-over-io_uring Support for
 QEMU FUSE Exports
Message-ID: <aH-rdx4HisUvpu6-@redhat.com>
References: <20250716183824.216257-1-hibriansong@gmail.com>
 <20250716183824.216257-2-hibriansong@gmail.com>
 <20250721005346.GB32887@fedora>
 <CAKWCU7WEv=qohQJ6XUzHS9ffHN8gT0yuRZojmrTgpqja3ghaiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKWCU7WEv=qohQJ6XUzHS9ffHN8gT0yuRZojmrTgpqja3ghaiw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.633,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Am 22.07.2025 um 14:00 hat Brian Song geschrieben:
> On 7/20/25 8:53 PM, Stefan Hajnoczi wrote:
> > On Wed, Jul 16, 2025 at 02:38:24PM -0400, Brian Song wrote:
> >> +    case FUSE_FSYNC:
> >> +        ret = fuse_co_fsync(exp);
> >> +        break;
> >> +
> >> +    case FUSE_FLUSH:
> >> +        ret = fuse_co_flush(exp);
> >> +        break;
> >> +
> >> +#ifdef CONFIG_FUSE_LSEEK
> >> +    case FUSE_LSEEK: {
> >> +        const struct fuse_lseek_in *in =
> >> +                        (const struct fuse_lseek_in *)&rrh->op_in;
> >> +        ret = fuse_co_lseek(exp, (struct fuse_lseek_out *)out_op_hdr,
> >> +                            in->offset, in->whence);
> >> +        break;
> >> +    }
> >> +#endif
> >> +
> >> +    default:
> >> +        ret = -ENOSYS;
> >> +    }
> >
> > It would be nice to reuse the non-io_uring code rather than duplicating
> > the switch statement that covers each FUSE opcode. Is the memory layout
> > so different that the code cannot be shared?
> 
> Yes. But I think the main issue is that we have to handle too many
> differences when it comes to various operations and the final step of
> replying to the request. There would be a lot of #ifdef
> CONFIG_LINUX_IO_URING and if statements. So, for simplicity, I made it a
> separate function.
> 
> In the traditional model:
> q->request_buf = fuse_in_header + struct fuse_opsxx_in +
> FUSE_IN_PLACE_WRITE_BYTES (used for part of the payload data)
> q->spillover_buf is used for the rest of the payload data.
> 
> In Fuse-over-io_uring:
> FuseRingEnt contains req_header (which includes in_out for
> fuse_in/out_header, and op_in for struct fuse_opsxx_in)
> op_payload corresponds to the final FUSE_IN_PLACE_WRITE_BYTES bytes from
> request_buf + spillover_buf in the traditional model but carries either
> the out operation headers (fuse_ops_out) or the file data to be written
> or read.

The individual opcode handlers you call from both functions are already
generic enough to work for both cases, e.g. fuse_co_write() takes both
an in_place_buf and spillover_buf. In the io_uring case you just pass
NULL for in_place_buf.

Why doesn't the same approach work for fuse_co_process_request()? Can't
you just pass three pointers for header, in_place_buf and spillover_buf
to it and have two very small wrappers around it that take care of
passing the right pointers for the respective case?

Kevin


