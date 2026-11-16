Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0B4606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 22:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VCg3BwkD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT4t2-00039P-OO; Mon, 16 Nov 2026 17:09:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xT4t1-00038R-GZ
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 17:09:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xT4sz-0000yU-S8
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 17:09:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794866952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nO18ObUIj7T/Q8q5xDukl+3qgbGp+YVixtMN6OruTXQ=;
 b=VCg3BwkDyFmqiaxba2Df3bgk6h7RI7EmqVQaW4fntvF7702WIdglQVbIgvxo5IcW7ewQvV
 j8fiTKPnToJSIPyAi3EVH7jB04YamHQIz6oJHJaAq5+44Ny0YGLD5eLVO05xHBymkFWS2l
 1TbhGAfgqz05JmCZVFlJwB87sGlM6Pw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-491-2GIrGKH9O9ynIL0Ly2T8Ig-1; Mon,
 16 Nov 2026 17:09:09 -0500
X-MC-Unique: 2GIrGKH9O9ynIL0Ly2T8Ig-1
X-Mimecast-MFC-AGG-ID: 2GIrGKH9O9ynIL0Ly2T8Ig_1794866948
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9A6E4180049D; Mon, 16 Nov 2026 22:09:08 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E5A0E195B3C2; Mon, 16 Nov 2026 22:09:07 +0000 (UTC)
Date: Mon, 16 Nov 2026 17:09:06 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Julio Faracco <jcfaracco@gmail.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 oxsignal <awo@kakao.com>
Subject: Re: [PATCH 1/2] block/dmg-lzfse: reject short LZFSE decodes
Message-ID: <20261116220906.GA145716@shajnocz.csb>
References: <20261112-dmg-short-decode-v1-0-f7f342097b60@gmail.com>
 <20261112-dmg-short-decode-v1-1-f7f342097b60@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112-dmg-short-decode-v1-1-f7f342097b60@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 12, 2026 at 12:33:56PM -0300, Julio Faracco wrote:
> dmg_uncompress_lzfse_do() treated any non-zero lzfse_decode_buffer()
> return as success. A crafted DMG can declare a larger chunk output size
> than its LZFSE stream decodes to, leaking the unzeroed tail of
> uncompressed_chunk to the guest as sector data -- a heap disclosure.
> 
> lzfse_decode_buffer() returns the destination capacity both for an
> exact-size and a too-small destination, so decode with one extra byte of
> capacity (allocated in dmg_open()): an exact stream returns avail_out, a
> short or oversized one does not. Require out_size == avail_out. Decoding
> in place also avoids a per-chunk g_malloc()/memcpy() of up to 64 MiB in
> the read path.
> 
> zlib and bzip2 chunk paths already enforce this; LZFSE did not.
> 
> Fixes: CVE-2026-116483
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4662
> Reported-by: oxsignal <awo@kakao.com>
> Signed-off-by: Julio Faracco <jcfaracco@gmail.com>
> ---
>  block/dmg-lzfse.c | 27 +++++++++++++++++++--------
>  block/dmg.c       |  8 +++++++-
>  2 files changed, 26 insertions(+), 9 deletions(-)
> 
> diff --git a/block/dmg-lzfse.c b/block/dmg-lzfse.c
> index 4ea0b9b20d..b1acd87135 100644
> --- a/block/dmg-lzfse.c
> +++ b/block/dmg-lzfse.c
> @@ -33,16 +33,27 @@
>  static int dmg_uncompress_lzfse_do(char *next_in, unsigned int avail_in,
>                                     char *next_out, unsigned int avail_out)
>  {

The +1 approach could cause bugs in the future. block/dmg.h does not
document that avail_out + 1 bytes may be written to next_out:

  typedef int BdrvDmgUncompressFunc(char *next_in, unsigned int avail_in,
                                    char *next_out, unsigned int avail_out);

I would rather avoid the dangerous +1 even if it means oversized
compressed inputs are not detected. So how about only checking that the
return value from lzfse_decode_buffer() is out_size and returning -1 if
it is smaller?

Stefan


