Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA363C3DA61
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 02:34:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYcg4-0004o6-Dz; Mon, 29 Jul 2024 22:33:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1sYcg1-0004n3-58; Mon, 29 Jul 2024 22:33:25 -0400
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1sYcfy-0000WO-Lz; Mon, 29 Jul 2024 22:33:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Type:MIME-Version:Message-ID:Date:References:
 In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MCS7QX/fDZWzrE9xUFB3LeDIZuYBfAL5DGtiBPec42Y=; b=mMhf3XtJ0KhOH1T3kn9z0uCXIw
 qtj5eW9N1lbOa0/bvoj1BcuAUVeStSFInWUX697EFPtnbCcr7W1putuirYZMRGI/TxNWtn0Uv+ctK
 YxyHRrzFCXB6xKC4Je17M5rESK08usKUyL4VXsqA7cdCu6pnnwSLZjfH/uBB/TkdOSpiXOeeoyfja
 2wWotMcxJM3pm1UO/Ge0K+z2Xb7MFuFybsuVHqRohJ4VJGztBRwgl69SxHSMOdcmW9vcYDlrTtUuH
 UxuaEBBzC1eBlDiJUK3ED69lJFwduLCvRVuMAC5rapuz9uGR2tBfN37fRqIzXWpVMeoVD0Lf38e2i
 WtfTvnCQ==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine2.igalia.com with esmtps 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1sYYL8-004Nj4-Mk; Mon, 29 Jul 2024 23:55:34 +0200
Received: from gate.service.igalia.com ([192.168.21.52])
 by mail.igalia.com with esmtp (Exim)
 id 1sYYL6-00BfKf-JA; Mon, 29 Jul 2024 23:55:34 +0200
Received: from berto by gate.service.igalia.com with local (Exim 4.96)
 (envelope-from <berto@igalia.com>) id 1sYYL6-004ya0-1N;
 Mon, 29 Jul 2024 21:55:32 +0000
From: Alberto Garcia <berto@igalia.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Hanna
 Czenczek <hreitz@redhat.com>, Nir Soffer <nsoffer@redhat.com>, Madeeha
 Javed <javed@igalia.com>
Subject: Re: [PATCH v3] scripts/qcow2-to-stdout.py: Add script to write
 qcow2 images to stdout
In-Reply-To: <pz7gy26uyetg2d7vzudxtoiwqppd4iddo7ctno7lrbumghxzvf@nny3z2qshvsc>
References: <20240729150226.71250-1-berto@igalia.com>
 <pz7gy26uyetg2d7vzudxtoiwqppd4iddo7ctno7lrbumghxzvf@nny3z2qshvsc>
Date: Mon, 29 Jul 2024 23:55:32 +0200
Message-ID: <w51mslz278r.fsf@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine2.igalia.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Mon 29 Jul 2024 03:20:18 PM -05, Eric Blake wrote:
> On Mon, Jul 29, 2024 at 05:02:26PM GMT, Alberto Garcia wrote:
>> +# qcow2 files produced by this script are always arranged like this:
>> +#
>> +# - qcow2 header
>> +# - refcount table
>> +# - refcount blocks
>> +# - L1 table
>> +# - L2 tables
>> +# - Data clusters
>
> Is it easy to make your tool spit out a qcow2 image with external data
> file (to write a quick qcow2 wrapper for an existing file to now be
> used as external data)?  Or is that too much of a difference from the
> intended use of this tool?

I didn't consider that use case and I didn't want to make the tool too
complicated. It's probably not very hard to do, if I can do it without
too many changes to the code I'll give it a try.

>> +def clusters_with_data(fd, cluster_size):
>> +    data_off = 0
>> +    while True:
>> +        hole_off = os.lseek(fd, data_off, os.SEEK_HOLE)
>> +        for idx in range(data_off // cluster_size, math.ceil(hole_off / cluster_size)):
>> +            yield idx
>> +        try:
>> +            data_off = os.lseek(fd, hole_off, os.SEEK_DATA)
>
> Depending on the size of cluster_size, this could return the same
> offset more than once (for example, for 1M clusters but 64k
> granularity on holes, consider what happens if lseek(0, SEEK_HOLE)
> returns 64k, then lseek(64k, SEEK_DATA) returns 128k: you end up
> yielding idx 0 twice).  You may need to be more careful than that.

I literally opened my laptop because I just realized that this could be
a problem :D I'll fix it in the next version.

>> +        ret = subprocess.run(
>> +            [
>> +                QEMU_STORAGE_DAEMON,
>> +                "--daemonize",
>> +                "--pidfile", pid_file,
>> +                "--blockdev", f"driver=file,node-name=file0,driver=file,filename={input_file},read-only=on",
>> +                "--blockdev", f"driver={input_format},node-name=disk0,file=file0,read-only=on",
>> +                "--export", f"type=fuse,id=export0,node-name=disk0,mountpoint={raw_file},writable=off",
>> +            ],
>> +            capture_output=True,
>> +        )
>
> Does q-s-d exposing an image as raw still support lseek(SEEK_HOLE)
> efficiently?

Yes, I tested it before sending the new version, the improvements are
actually quite noticeable, thanks Nir for suggesting this.

>> +    parser.add_argument(
>> +        "-v",
>> +        dest="qcow2_version",
>> +        metavar="qcow2_version",
>> +        help=f"qcow2 version (default: {QCOW2_DEFAULT_VERSION})",
>> +        default=QCOW2_DEFAULT_VERSION,
>> +        type=int,
>> +        choices=[2, 3],
>
> Is it really worth trying to create v2 images?

I don't know, I added this because it required almost no changes to the
code. But I don't have a strong opinion, I can remove support for v2
images.

Berto

