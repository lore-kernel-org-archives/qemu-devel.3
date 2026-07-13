Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 138DFC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 20:23:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjNBa-00052m-GY; Mon, 13 Jul 2026 16:23:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1wjNBY-00052Y-Cv
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 16:23:28 -0400
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1wjNBW-0001Vb-7d
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 16:23:28 -0400
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.99.1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1wjNBJ-00000000OI1-0Kqx; Mon, 13 Jul 2026 22:23:13 +0200
Message-ID: <e602d0cd-dfc2-441d-a017-067e55418dad@maciej.szmigiero.name>
Date: Mon, 13 Jul 2026 22:23:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] vfio/migration: Parallelize device state transitions
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, Alex Williamson <alex@shazbot.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 qemu-devel@nongnu.org
References: <cover.1779217494.git.maciej.szmigiero@oracle.com>
 <743f03758d2a30df4093db140ccdd0f91f69bd7e.1779217494.git.maciej.szmigiero@oracle.com>
 <871peqtm5t.fsf@suse.de> <ah3eheRXN1QJAGj_@x1.local>
 <ac677bf9-1372-4905-a0b8-874a74be07be@maciej.szmigiero.name>
 <ah86Z0r5sMnxwgo-@x1.local>
 <c739f4fe-1f43-45c4-b98f-109366526405@maciej.szmigiero.name>
 <e79a3746-9c7e-46a5-ad81-537b9d3affdb@maciej.szmigiero.name>
 <akvWlciUvxjDbBBZ@x1.local>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Content-Language: en-US, pl-PL
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 xsFNBFpGusUBEADXUMM2t7y9sHhI79+2QUnDdpauIBjZDukPZArwD+sDlx5P+jxaZ13XjUQc
 6oJdk+jpvKiyzlbKqlDtw/Y2Ob24tg1g/zvkHn8AVUwX+ZWWewSZ0vcwp7u/LvA+w2nJbIL1
 N0/QUUdmxfkWTHhNqgkNX5hEmYqhwUPozFR0zblfD/6+XFR7VM9yT0fZPLqYLNOmGfqAXlxY
 m8nWmi+lxkd/PYqQQwOq6GQwxjRFEvSc09m/YPYo9hxh7a6s8hAP88YOf2PD8oBB1r5E7KGb
 Fv10Qss4CU/3zaiyRTExWwOJnTQdzSbtnM3S8/ZO/sL0FY/b4VLtlZzERAraxHdnPn8GgxYk
 oPtAqoyf52RkCabL9dsXPWYQjkwG8WEUPScHDy8Uoo6imQujshG23A99iPuXcWc/5ld9mIo/
 Ee7kN50MOXwS4vCJSv0cMkVhh77CmGUv5++E/rPcbXPLTPeRVy6SHgdDhIj7elmx2Lgo0cyh
 uyxyBKSuzPvb61nh5EKAGL7kPqflNw7LJkInzHqKHDNu57rVuCHEx4yxcKNB4pdE2SgyPxs9
 9W7Cz0q2Hd7Yu8GOXvMfQfrBiEV4q4PzidUtV6sLqVq0RMK7LEi0RiZpthwxz0IUFwRw2KS/
 9Kgs9LmOXYimodrV0pMxpVqcyTepmDSoWzyXNP2NL1+GuQtaTQARAQABzTBNYWNpZWogUy4g
 U3ptaWdpZXJvIDxtYWlsQG1hY2llai5zem1pZ2llcm8ubmFtZT7CwZQEEwEIAD4CGwMFCwkI
 BwIGFQoJCAsCBBYCAwECHgECF4AWIQRyeg1N257Z9gOb7O+Ef143kM4JdwUCaZD5QgUJESzD
 fQAKCRCEf143kM4JdxkAEAC9cPa1ONCizZerNCJR9fI1ezsYWjNYpTWoYWT2vWug8repG8EJ
 E6/l300/TRf0kYy9vNC0PUe+uJeJig2HxfwuCAHECobvvANSEq+KTUXq1sE3tJ7ZKCZwDiR/
 zs4axmFlZVzFUHkzCqH/y7xBBHHQJrtSD0W/Gs1DbCb1xCblyE4uzQ9DytlxkZdVgXt3Fmm8
 Xa6JAxoDnUktl6LWpQ4tW6IRXN4gOQeRQKzREIIbk1gEvba/60JvuS1GX2KK2/SRODspF9TV
 5IKHmnepKOSpwLhkR3U4uV1D/4aqcJaDsH1krdAse5nkyXXQ7aBMvGLx2KADaoq6uhBFswyZ
 L7/AuhKEq4+YTuvE+EBYJS1YXFCisqQgG2zDGQc2I5AVpQlF6isKa+kcQBT7V27XuSrcsYdH
 Op7nJynlyBg7nYkgAdy+zLgQ+0fgCmtWha5qJUP6oVWcMfA6btSiN+rNkMylqgXbkeHgdDkr
 1+VshxGvQSMm/4DStFJwZ7zEln9qxr4AQbfdugNZmMb3F/haKvUuNh2TJHICgbwjEDryZipf
 2iUjqBVVzW4ut7fgHkBq9yw2Vy5ryr+R/N/1Pja6gvtvU53dfDIGXxBRGTQFD92xXVd/Ml8/
 G0QvpiUCuUBvVGJb8k0Xlx9CYWlyFqoNUevPW8e8CCw+j3i+H9tMPuvJjs7AzQRaRrwiAQwA
 xnVmJqeP9VUTISps+WbyYFYlMFfIurl7tzK74bc67KUBp+PHuDP9p4ZcJUGC3UZJP85/GlUV
 dE1NairYWEJQUB7bpogTuzMI825QXIB9z842HwWfP2RW5eDtJMeujzJeFaUpmeTG9snzaYxY
 N3r0TDKj5dZwSIThIMQpsmhH2zylkT0jH7kBPxb8IkCQ1c6wgKITwoHFjTIO0B75U7bBNSDp
 XUaUDvd6T3xd1Fz57ujAvKHrZfWtaNSGwLmUYQAcFvrKDGPB5Z3ggkiTtkmW3OCQbnIxGJJw
 /+HefYhB5/kCcpKUQ2RYcYgCZ0/WcES1xU5dnNe4i0a5gsOFSOYCpNCfTHttVxKxZZTQ/rxj
 XwTuToXmTI4Nehn96t25DHZ0t9L9UEJ0yxH2y8Av4rtf75K2yAXFZa8dHnQgCkyjA/gs0ujG
 wD+Gs7dYQxP4i+rLhwBWD3mawJxLxY0vGwkG7k7npqanlsWlATHpOdqBMUiAR22hs02FikAo
 iXNgWTy7ABEBAAHCwXwEGAEIACYCGwwWIQRyeg1N257Z9gOb7O+Ef143kM4JdwUCaZD5YwUJ
 ESzCOAAKCRCEf143kM4Jd4+KEADEBLxVKXGqinMD1nb/QPA0Rj35WluRdPIB2dcDcyTOtiyN
 ErIQQMhr0W4sxZOd741a2nv89VZKjzBNjihOZgbEuHfG/0lhIZ5t6aF7k4gbMctzQT7utzmD
 y5OoV+/VFHguLThwxRvCMkGEieE8Cb4muYdQgaq1s5ipV1IqF3cDYg2iGupnsYSgOfw7ZyvG
 9c7Fxn7jiD/wI9eL3AesCkVFbF0r/9yLbuW6vh3kd/+bORO1GK4snSjrZLi04bnihnDfa33N
 Pik3cmUZZANzo+HkADZjJ1pl3DZn1Qj8STk6YhaTtJhLKH4lteAlSS4xRIeoiw/2hbzbRr4j
 hnu96hf6ukM7E7oC89SfWGXZHbUds77MFyKvBTCMJnkQq+PbmYp1vgTnOl3JO7ARZ3rNPkHE
 IpOWDjHRyDiKVVxt2bKaELZrFGcYYTVXt9pUfY1xFt76G0piVr50+jTezgMmZYr7aZOrqlUi
 WHQjcZZbROLql/+ngphSgdthGIhVWrIMHJu1UxnRiwKc/fzDFUZ9hFL+W4ZLm+52TzMatpta
 oNdcP9rtsQjdYMNLuwysP4keDX8yBXADwJD7eQ+ryIIKh6X1lBMIWxeZG5W0DQ6/4BCUEbCe
 1DqkYRtZyUEzgAbaHliaa5t3dfCtSMz5cAbGqxarXc7bKOjA6P8hCwgP0tEypA==
In-Reply-To: <akvWlciUvxjDbBBZ@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 6.07.2026 18:23, Peter Xu wrote:
> On Thu, Jul 02, 2026 at 08:36:32PM +0200, Maciej S. Szmigiero wrote:
>> I looked more deeply into this and even prototyped a similar new design.
> 
> Sorry for a late response; off work most of last week.

Also sorry for my late response - was extremely busy the entire previous week.

>>
>> However, in the end I think that running VFIO state transitions in
>> parallel with other non-VFIO cb() handlers just isn't safe.
>>
>> For example, on the migration source, the second transition is
>> PRE_COPY_P2P -> STOP_COPY.
>> PRE_COPY_P2P is the last state during migration that still allows the
>> device to accept DMA and similar interactions, while STOP_COPY is
>> already the "quiescent" state.
>>
>> So if a VFIO has already reached STOP_COPY but a non-VFIO device
>> callback still hasn't finished, then any DMA/MMIO/P2P transaction from
>> that "unfinished" device to the VFIO device would now hit a VFIO device
>> that no longer can accept such transactions.
>> This may result in hard-to-debug memory corruption during live migration.
> 
> Do you have any solid example of this problem?
> 
> AFAIU, P2P in VFIO state's term only means P2P DMAs _between_ host VFIO
> devices, nothing to do with emulated.

I presume that quiescent VFIO devices can't accept *any* DMA, the spec (vfio.h)
even says that:
> The user should take steps to restrict access to vfio device regions while
> the device is in STOP_COPY or risk corruption of the device migration data
> stream.

Correspondingly, I think the same goes for RESUMING state on the migration
target since it is described there as:
> The device is *stopped* and is loading a new internal state

While you are right that the spec only talks about P2P DMA I don't see how
host-initiated DMA would be different here - after all, it's about changing
internal device state in a state where the device can't accept that anymore/yet.

> I am not aware of any P2P that can be initiated from emulated devices, even
> if it exists, it is only P2P from guest perspective not host: it will
> become host operations finally from processor side.  I really don't think
> it's a concern.

Yeah, it's normal DMA from the VFIO device perspective.
  > My limited understanding of VFIO's P2P state is: when switching to P2P
> state, the VFIO device can still accept P2P DMA from other devices, but
> never initiating P2P DMAs, and the latter sentence is critical, it means
> the real quiecent state of the whole system happens after the last VFIO
> device switching to P2P state: then it means none of the VFIO devices can
> initiate P2P DMA anymore, whole system is quiesced. 

Just having the VFIO devices in the system prevented from being able to
initiate DMA is not enough for them to reach "quiecent" or fully stable
state as long as there are other possible sources of DMA transactions
targeting them in the system.

Glancing at the existing vm_state_change handlers there are some
concerning ones there:
* vhost-net (called via virtio_vmstate_change() in base virtio-net),

In the vhost-net case the vm_state_change handler for this device
ultimately reaches vhost_net_stop() and do_vhost_dev_stop() and these
seem to stop this network device rings at this point.

Now, having vhost-net packet buffers in a VFIO device MMIO BAR would
be rather atypical configuration, but nevertheless letting VFIO
device possibly reach "quiecent" state before this handler finishes
would theoretically be a regression.

* virtio-blk virtio_blk_dma_restart_cb() vm_state_change handler
submits some block requests to its (possibly dedicated) IOThread.

Again, having block device request buffers in a VFIO device MMIO BAR
would not be a typical configuration, however letting this handler
run before making sure that VFIO devices can accept DMA would
theoretically make a regression too.

* same for scsi-bus scsi_dma_restart_cb() that does
scsi_dma_restart_req() for each pending request.


The above is not an exhaustive list, these are only the cases
I was able to identify relatively easily by going through the
code.
And I think that with possible memory corruption issues its better
to be safe than sorry, as they are pain to debug.

The only real non-VFIO cost of being safe about all of this is
~15 code lines addition to vm-change-state-handler.c, all the
remaining complexity is already on the VFIO side of things.
> That happens earlier
> than reaching any of the cb()s here, because VFIO's prepare_cb() does that
> P2P state switch.

I thought your proposed design was to launch (per-VFIO device)
device state changing thread in prepare_cb(), make it do *both*
VFIO device state transitions and collect it in cb()?

In this case the transitions are *NOT* ordered with respect to
other cb() handlers (besides them being finished by the time
the VFIO device qdev tree depth cb() handlers are reached by
virtue of the threads being collected at this point - this is
actually necessary in order to preserve proper ordering with
respect to some types of interrupt controllers on the source).

So on the migration source the thread could already put device
into "quiecent" state by the time other cb() handlers could run
and on the migration target the device could still be
in an "unprepared" state by the time other cb() handlers are called.

> 
> Thanks,
> 

Thanks,
Maciej


