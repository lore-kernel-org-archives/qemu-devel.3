Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1098EC369B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 16:32:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5S9U-0008Ut-Fn; Thu, 17 Apr 2025 12:31:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u5S9O-0008UD-Tv
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 12:31:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u5S9M-00088r-HD
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 12:31:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744907499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kpmnI/zFj+Q46DwWbjboqSREd8Tk63fwfty0a9i//OM=;
 b=SBPAtSnrZhp1vns8gSBQ0KlFp68cgDSd81yV9VXW0maUhCd+nX3hmJIcOae3NZbFDWv7jw
 915RDOiA45ttgX4PBIe+TeIkF9qpSBM6TEWgecx4oS+wWLlPeDJyOMpVqDDoJsdmYSFEy7
 +bWCRer8upApQOEbos8bQ+ybV9vsmeg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-580-d2g7Fy0SMM6abGv8ior1UA-1; Thu,
 17 Apr 2025 12:31:35 -0400
X-MC-Unique: d2g7Fy0SMM6abGv8ior1UA-1
X-Mimecast-MFC-AGG-ID: d2g7Fy0SMM6abGv8ior1UA_1744907494
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 30F5119560A5; Thu, 17 Apr 2025 16:31:33 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.121])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BB0F730002C2; Thu, 17 Apr 2025 16:31:30 +0000 (UTC)
Date: Thu, 17 Apr 2025 11:31:27 -0500
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>, 
 qemu-block@nongnu.org, Fam Zheng <fam@euphon.net>,
 Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v3 1/2] file-posix: probe discard alignment on Linux
 block devices
Message-ID: <urdfcw64c2a67vap573n3b6u7jumreojwnnswnyqhf2lskb36r@hilkorjvqubo>
References: <20250414201214.241351-1-stefanha@redhat.com>
 <20250414201214.241351-2-stefanha@redhat.com>
 <wk6gm5wkvnjmo23j45kzukscd3nyve62fvtkloggqnad6m3knf@ugym5o7hgd52>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wk6gm5wkvnjmo23j45kzukscd3nyve62fvtkloggqnad6m3knf@ugym5o7hgd52>
User-Agent: NeoMutt/20250404
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Apr 17, 2025 at 11:27:42AM -0500, Eric Blake wrote:
> On Mon, Apr 14, 2025 at 04:12:13PM -0400, Stefan Hajnoczi wrote:
> > Populate the pdiscard_alignment block limit so the block layer is able
> > align discard requests correctly.
> > 
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  block/file-posix.c | 67 +++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 66 insertions(+), 1 deletion(-)
> > 
> 
> > +static int get_sysfs_u32_val(struct stat *st, const char *attribute,
> > +                             uint32_t *u32)
> > +{
> > +    g_autofree char *str = NULL;
> > +    const char *end;
> > +    unsigned int val;
> > +    int ret;
> > +
> > +    ret = get_sysfs_str_val(st, attribute, &str);
> > +    if (ret < 0) {
> > +        return ret;
> > +    }
> > +
> > +    /* The file is ended with '\n', pass 'end' to accept that. */
> > +    ret = qemu_strtoui(str, &end, 10, &val);
> > +    if (ret == 0 && end && *end == '\0') {
> 
> This doesn't match the comment.  If we expect the file contents to end
> in \n, then this should be checking *end == '\n', not '\0'.

Then again, get_sysfs_str_val() strips the trailing \n, so the code is
correct, and the comment is fishy.

But now, if we expect there to be no trailing garbage (after we've
stripped the \n when getting the string), we could simplify by passing
NULL instead of &end to qemu_strtoui, and merely rely on "if (ret == 0)".

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


