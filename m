Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EBD8C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 22:15:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpx0s-0005ll-Ic; Wed, 05 Mar 2025 17:14:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tpx0q-0005lE-Fh
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 17:14:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tpx0o-0003I5-8n
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 17:14:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741212881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jXslIZ1zY8oZPZT6VM+Y+dPHbTVuif9ZkxJmp0Am2o0=;
 b=SD0sYrY+Tekodf7L0OZ3hGMpVvfx6yPbGDpK05BisL8ULFhKXV7gP3NnzfjgndeWbkcLNd
 2hb/8/uRJOMZkKPdtf4PnuOTu+RxN3zOyqey9rXuNJor5y0MDAPV4jK4wjhe3MbkSRAdcA
 IUT5t3GHpmLs8w9IVrA3eAiaMS7IZDY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-324-u8zg5Y6qOsugJNsUcDzOfg-1; Wed,
 05 Mar 2025 17:14:21 -0500
X-MC-Unique: u8zg5Y6qOsugJNsUcDzOfg-1
X-Mimecast-MFC-AGG-ID: u8zg5Y6qOsugJNsUcDzOfg_1741212860
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B46C01800874; Wed,  5 Mar 2025 22:14:20 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.105])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 376911955DCE; Wed,  5 Mar 2025 22:14:19 +0000 (UTC)
Date: Wed, 5 Mar 2025 16:14:16 -0600
From: Eric Blake <eblake@redhat.com>
To: prashant patil <pmgpatil@gmail.com>
Cc: qemu-devel@nongnu.org
Subject: Re: Query on the dirty bitmap
Message-ID: <pf24mn3twfrc2kfaszovdyj5rhh6d4r4ixawh2dyx5dbi5no3j@ryk4lzslrnye>
References: <CAFvsdYns1yO6Wsm8VKP_khbTPm09Kf5KDmBpeMSrjboyccK4Aw@mail.gmail.com>
 <d2276vugq6wureu6zzrwci5sdtg3b6gllqskjv7hfvuulsmhyn@anl3d5htudty>
 <CAFvsdYk0J7ybdu+dL+w70Po1bGypLopBkixPp-ZzmTA8MdTr0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFvsdYk0J7ybdu+dL+w70Po1bGypLopBkixPp-ZzmTA8MdTr0w@mail.gmail.com>
User-Agent: NeoMutt/20250113
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Wed, Mar 05, 2025 at 03:36:35PM +0530, prashant patil wrote:
> I was trying to read the bitmap of the running vm's disk. When I followed
> below mentioned commands, then I was able to read the bitmap properly.
> block-dirty-bitmap-add, block-dirty-bitmap-disable, nbd-server-start,
> nbd-server-add,

Up to here, everything you've done is indeed the ideal way to get at
the contents of a bitmap from a live qemu process over an NBD connection.

> qemu-img
> map with x-dirty-bitmap image-opts.

Here, this works, but feels like a hack, because it is relying on the
x-dirty-bitmap feature of qemu.  The libnbd project ships with an
application 'nbdinfo --map' that can read the same information as
'qemu-img map' but with a much nicer layout.  It's not going to
necessarily be faster, but because it is a fully-supported feature of
libnbd rather than a hack in qemu, it may prove more stable in the
long run, and certainly easier to understand.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


