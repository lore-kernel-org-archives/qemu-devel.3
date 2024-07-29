Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BF19C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 09:41:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYMsL-0002K7-1p; Mon, 29 Jul 2024 05:41:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1sYMs9-0002IC-0U; Mon, 29 Jul 2024 05:40:53 -0400
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1sYMs4-0003kT-9R; Mon, 29 Jul 2024 05:40:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Type:MIME-Version:Message-ID:Date:References:
 In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8cIngSOXNuzyHuQCs2+p3IVr5mfS7v96TYuocEL/Yuc=; b=oZcZNpzKN973iJk4PmMDaomCNn
 /UY2zS66b5eORJ9h2Fxc7PTEdIH5JkqTL4Z+rB10Vr7Q7Jl8j0hC9POitr7s6eN7iixMcOwc5erDu
 jHecLc4SJyTUBkURC1Lk4MxOJ8Y5BMd3OJnX0BU4hPpDxThopCZ9a+uA03ZkBNgKaYM7DsGVWfEl/
 gU4UD+a0R7RoM+TEfSgtgYoMjqOgotdVPypo0rld9JElV2dPzNXaL7DkaSQ+6Xqw3cFiC9h47fzW+
 dG+es3O1xSwXU+k0kHjJjaTfSGGFRsXbQWobZV0ERkEYYdZcX6J3JNtlPnxBCxQ+QMDy4I5WB7dmO
 oDQ9rbmg==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine2.igalia.com with esmtps 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1sYMrr-003d1P-Lu; Mon, 29 Jul 2024 11:40:35 +0200
Received: from gate.service.igalia.com ([192.168.21.52])
 by mail.igalia.com with esmtp (Exim)
 id 1sYMrp-00Av5D-Im; Mon, 29 Jul 2024 11:40:35 +0200
Received: from berto by gate.service.igalia.com with local (Exim 4.96)
 (envelope-from <berto@igalia.com>) id 1sYMrp-004qhQ-1N;
 Mon, 29 Jul 2024 09:40:33 +0000
From: Alberto Garcia <berto@igalia.com>
To: Nir Soffer <nsoffer@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>, Eric Blake <eblake@redhat.com>, Kevin
 Wolf <kwolf@redhat.com>, Hanna Czenczek <hreitz@redhat.com>, Madeeha Javed
 <javed@igalia.com>
Subject: Re: [PATCH v2] scripts/qcow2-to-stdout.py: Add script to write
 qcow2 images to stdout
In-Reply-To: <CAMRbyysVzAB9DnJsrXfbdJJ5uDYJHEsgiNk=3wLkOisus59q5g@mail.gmail.com>
References: <20240701151140.29775-1-berto@igalia.com>
 <CAMRbyysVzAB9DnJsrXfbdJJ5uDYJHEsgiNk=3wLkOisus59q5g@mail.gmail.com>
Date: Mon, 29 Jul 2024 11:40:33 +0200
Message-ID: <w51ed7c7cz2.fsf@igalia.com>
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

On Sun 28 Jul 2024 01:01:07 AM +03, Nir Soffer wrote:
>> +def bitmap_set(bitmap, idx):
>> +    bitmap[int(idx / 8)] |= 1 << (idx % 8)
>
> Should use floor division operator (//):
>
>     bitmap[idx // 8] |= 1 << (idx % 8)
>
> Same for bitmap_test().

Right, also for all other cases of int(foo / bar). I'll update them.

>> +        ret = subprocess.run(
>> +            [
>> +                QEMU_STORAGE_DAEMON,
>> +                "--daemonize",
>
> Any reason to daemonize? managing the child process is easier if you
> don't daemonize.

--daemonize guarantees that when subprocess.run() returns the exported
raw_file is ready to use.

>> +            if len(cluster) < cluster_size:
>> +                cluster += bytes(cluster_size - len(cluster))
>
> This should be done only for the last cluster.

But that's what that condition is for, we'll only read less than
cluster_size bytes at the end of the file.

>> +                if not bitmap_test(l1_bitmap, l1_idx):
>> +                    bitmap_set(l1_bitmap, l1_idx)
>> +                    allocated_l2_tables += 1
>
> This could be much more efficient using SEEK_DATA/SEEK_HOLE, avoiding
> reading the entire image twice. Or using "qemu-img map --output json"
> to simplify.

I prefer not to have external dependencies(*) so I would rather not use
qemu-img, but I certainly can use SEEK_DATA/SEEK_HOLE to avoid reading
data that is known to be zero in the first pass.

(*) there is of course qemu-storage-daemon but that one is optional and
    I anyway cannot implement its functionality in this script.

>> +                sys.stdout.buffer.write(cluster)
>> +            else:
>> +                skip += 1
>
> If would be easier to work with if you add a function iterating over
> the l2_entries, yielding the he cluster index to copy:
>
>   def iter_l2_entries(bitmap, clusters):
>     for idx in range(clusters):
>       if bitmap_test(bitmap, idx):
>         yield idx
>
> The copy loop can read using os.pread():
>
>     for idx in iter_l2_entries(l2_bitmap, total_data_clusters):
>         cluster = os.pread(fd, cluster_size, cluster_size * idx)
>         sys.stdout.buffer.write(cluster)
>
> I'm not sure the offset is right in my example, it is hard to
> understand the semantics of skip in your code.

That part reads the input file sequentially from start to end, but
instead of reading empty clusters we use seek() to skip them. The 'skip'
variable keeps a counter of empty clusters since the last read.

Your proposal requires an additional function but I see that it can make
the code more readable, so I'll give it a try.

>> +if __name__ == "__main__":
>
> Usually code is easier to work with when __main__  calls main().

Good idea.

Thanks for the detailed review!

Berto

