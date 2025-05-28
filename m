Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9DD2C5AD49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 18:48:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKLoj-0001LU-P8; Wed, 28 May 2025 14:47:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uKLoh-0001KD-VZ
 for qemu-devel@nongnu.org; Wed, 28 May 2025 14:47:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uKLoe-0000qC-F6
 for qemu-devel@nongnu.org; Wed, 28 May 2025 14:47:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748458068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=y2e6/Wh5nDoxFFkX9dW3B7C9waL9XLEWwKajPtqB3W8=;
 b=OyIdu/q3UdTzt/zQAQFfS+Q1LzrLaElzm9vxYUwBkhSBpQBqW6sLlNqZ1YRjs7aUP+YosK
 mtszzOJgLUwm5Rs9jp9BzlVIUFNk6z2cVbga4KXX+nAn1AWIduVBZHk7VDpH58sgcChY6H
 jlQyiBnfzxHgZjnKlQngniSG7ydj+jk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-9a1B3X4aN5m6Fx0xOB7aXA-1; Wed,
 28 May 2025 14:47:36 -0400
X-MC-Unique: 9a1B3X4aN5m6Fx0xOB7aXA-1
X-Mimecast-MFC-AGG-ID: 9a1B3X4aN5m6Fx0xOB7aXA_1748458055
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4D74319560AA; Wed, 28 May 2025 18:47:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.38])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A300C1956094; Wed, 28 May 2025 18:47:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1AF2421E6768; Wed, 28 May 2025 20:47:30 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org,  qemu-block@nongnu.org,  f.ebner@proxmox.com,
 Kevin Wolf <kwolf@redhat.com>,  Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v2 2/3] iotests: Improve mirror-sparse on ext4
In-Reply-To: <zv3gucwyoogzcamqvzskfodvzbbxlg64radbut2sq53avi5qud@w6n4pxekypzc>
 (Eric Blake's message of "Wed, 28 May 2025 13:32:04 -0500")
References: <20250523163041.2548675-5-eblake@redhat.com>
 <20250523163041.2548675-7-eblake@redhat.com>
 <ibn5a3mq4co2h5rpslkq42hir4ka4dz5fsgcbmuwqnoiwarhmf@5qlu3ssskquc>
 <zv3gucwyoogzcamqvzskfodvzbbxlg64radbut2sq53avi5qud@w6n4pxekypzc>
Date: Wed, 28 May 2025 20:47:30 +0200
Message-ID: <87cybstvwd.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Eric Blake <eblake@redhat.com> writes:

> On Wed, May 28, 2025 at 10:45:35AM -0500, Eric Blake wrote:
>> On Fri, May 23, 2025 at 11:27:22AM -0500, Eric Blake wrote:
>> > Fiona reported that an ext4 filesystem on top of LVM can sometimes
>> > report over-allocation to du (based on the hueristics the filesystem
>> > is making while observing the contents being mirrored); even though
>> > the contents and actual size matched, about 50% of the time the size
>> > reported by disk_usage was too large by 4k, failing the test.  In
>> > auditing other iotests, this is a common problem we've had to deal
>> > with.
>> > 
>> > Reported-by: Fiona Ebner <f.ebner@proxmox.com>
>> > Fixes: c0ddcb2c ("tests: Add iotest mirror-sparse for recent patches")
>> > Signed-off-by: Eric Blake <eblake@redhat.com>
>> > Reviewed-by: Fiona Ebner <f.ebner@proxmox.com>
>> > Tested-by: Fiona Ebner <f.ebner@proxmox.com>
>> > 
>> > ---
>> > v2: Drop sync for ZFS
>> > ---
>> >  tests/qemu-iotests/tests/mirror-sparse | 4 +++-
>> >  1 file changed, 3 insertions(+), 1 deletion(-)
>> 
>> Squashing this in since Markus is reporting failures even with this
>> patch applied, and I'm lacking enough context to see what else might
>> be interfering:
>> 
>> diff --git i/tests/qemu-iotests/tests/mirror-sparse w/tests/qemu-iotests/tests/mirror-sparse
>> index 39e3196c811..a30e52de41d 100755
>> --- i/tests/qemu-iotests/tests/mirror-sparse
>> +++ w/tests/qemu-iotests/tests/mirror-sparse
>> @@ -105,7 +105,7 @@ if test $result -lt $((3*1024*1024)); then
>>  elif test $result -gt $((19*1024*1024)); then
>>      actual=full
>>  else
>> -    actual=unknown
>> +    actual="unexpected size ($result)"
>
> I reproduced Markus' situation on XFS (since XFS is easier than ZFS to
> install on Fedora) - it turns out that XFS rounds disk usage in terms
> of allocation groups which default to a size of 1M; so I need to treat
> exactly 3M as sparse, not unknown.  I'm also squashing in:
>
> diff --git i/tests/qemu-iotests/tests/mirror-sparse w/tests/qemu-iotests/tests/mirror-sparse
> index a30e52de41d..cfcaa600ab4 100755
> --- i/tests/qemu-iotests/tests/mirror-sparse
> +++ w/tests/qemu-iotests/tests/mirror-sparse
> @@ -100,7 +100,7 @@ $QEMU_IMG compare -U -f $IMGFMT -F raw $TEST_IMG.base $TEST_IMG
>  # Some filesystems can fudge allocations for various reasons; rather
>  # than expecting precise 2M and 20M images, it is better to allow for slop.
>  result=$(disk_usage $TEST_IMG)
> -if test $result -lt $((3*1024*1024)); then
> +if test $result -lt $((4*1024*1024)); then
>      actual=sparse
>  elif test $result -gt $((19*1024*1024)); then
>      actual=full

This one-liner appears to fix it for me.  Thanks!


