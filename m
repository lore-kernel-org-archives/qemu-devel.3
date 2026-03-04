Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90C99EF8FE1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 13:12:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxm1K-00010i-1d; Wed, 04 Mar 2026 08:12:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1vxm1J-00010S-BZ
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:12:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1vxm1H-0006wQ-HL
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 08:12:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772629926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G+D59/2ncoRz7Huw6vWqIRn5RSCFhoanYd+6MSUcsKc=;
 b=S8tKbDq1eq6wfRFodl/abm5bVzMlOWh27uqGWPVPWe+EuLrjfAriozbN7bQNZ7yaJcUeqp
 7UqyJOnkfYczuz+Xvd8SW4bwtkfwEakPz6vK9mHmhqucJS10+6gx3x2pg690O/Wuyorbs3
 MmJEzmkNo1LMuj96f0FuCCVygW6d9uI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-pt6rriltPIeJM5ZGJQG2ig-1; Wed, 04 Mar 2026 08:12:05 -0500
X-MC-Unique: pt6rriltPIeJM5ZGJQG2ig-1
X-Mimecast-MFC-AGG-ID: pt6rriltPIeJM5ZGJQG2ig_1772629924
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-439beddef55so2227337f8f.0
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 05:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772629924; x=1773234724; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=G+D59/2ncoRz7Huw6vWqIRn5RSCFhoanYd+6MSUcsKc=;
 b=l+Nzf9HpTPDERcJRDSKZd8eKmd8bG4M/lUKRt23oxCqtzWcoF+bbAgprCiNcLciD9r
 oVF18At/OiD5+7tX8f4DBF0uCJ1alGNUW1tOSOx+3c6ymU3y2UoF4n0uTtfGWMGPVoqe
 qBS5W+JSFS72Pny90+x6Kd04AVlaLonGwuE/HgnRQk9phemDdiDNSYL1PPNaBGZR7ONU
 KsXqhEhx4SdfjCED9v/jlAuiDsXriB3oIc1LG88ggsujpnNQsppUXAGKGO7aEKd7BPd0
 i6W/NhUHQZBFLIB55j3ah8b3H1T8ugNeioBujeUsa7vCm4YQC+gelR8PXqcwSZoKDqJQ
 z9sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772629924; x=1773234724;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G+D59/2ncoRz7Huw6vWqIRn5RSCFhoanYd+6MSUcsKc=;
 b=JbYw9ADWaeIlnIk/OdBgznehiH7dJaK5io+IVvUcqaHoRxzbJeO23CIs8oTo9MOkmt
 O0ATUw1pNCdMCvUL4y85VP2TsdiaZmgsJlKST3rDg5+xWDeWYKqc5UgCZWTZKsZSYhu7
 aykNPqk9huMG/XZtmtjmqs9Suz3ASDN2xX/I7zBJzSHoHN0EG5UARhxZregWC2Ye9rz1
 UuQcw6ae9w1rW0mrc15vrTHlXvHBYXyHfI2M9PDKCnS46ltLaEfYWjYbqm+UPSBM8vwZ
 /ZJjpD+MhbKH8m0QCp9vVaWnXqX1HhBdIp6zVYF/1i1BF4LfAEsyQhgFhkL8jgBt8HLl
 S7bg==
X-Gm-Message-State: AOJu0Yx6zyhh+vI6YErqgs6r0NdRwTnwJ3woMsRZqOmqH4jggxRVVfU6
 08F4rqULFpTShuOrMZDujuGXC1qSE5qk7g0G1x0vOLnTTU3QN/gb30pbqgZiR1BA8dzBDjs4DlP
 EblWEgfRhH4F+OBv3Nup4E9JL0k4HFWTVKDiv/wVdGnrXAz7uex1jYE2L
X-Gm-Gg: ATEYQzw1Lx1hHq2pmlT7jsqu5py+hHO6SKPklnt56rh7VcpUKxNt1twqUj9cudXn0t+
 Dfcg0OZv2Nz2Ehph8nlsmFkjNUIF2OfGhsJDP0K9mkpUW4Yuq53E9Jed5eOOVRfd7tcCAo4XvvC
 qQ6yrFzGkpg6pah0RQmgh1iMwJ8EEl53+WH7DJJdsf6XhhJdmWwGH1EYAeaNw2kKWEyraK6Rms0
 n7SMrHt2vrt5LfSvp57N0v5DM5TNwwL5uehwNNLM+iq1ggYkJ4A395UazI/WcFLoQjQGJGlHDSO
 hu8XxjVESkj0+GEyXpXeM8Mcpo4lUI3qrytYDPGhbO4IsWoOsDXb8k5E1r+89ycpNfsEbCYIcpQ
 roP5GV1JyRSQwBuEv7kox43O+YleKNWw5ZP1YXQHh7SEZYRRvqBm1gmWETonfTXOhwdzfrzk=
X-Received: by 2002:a05:6000:2f86:b0:439:ba75:7dab with SMTP id
 ffacd0b85a97d-439c7f65059mr3701129f8f.9.1772629923847; 
 Wed, 04 Mar 2026 05:12:03 -0800 (PST)
X-Received: by 2002:a05:6000:2f86:b0:439:ba75:7dab with SMTP id
 ffacd0b85a97d-439c7f65059mr3701064f8f.9.1772629923281; 
 Wed, 04 Mar 2026 05:12:03 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-58.retail.telecomitalia.it.
 [82.53.134.58]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439b55df68dsm23819504f8f.26.2026.03.04.05.12.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 05:12:02 -0800 (PST)
Date: Wed, 4 Mar 2026 14:11:56 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, mst@redhat.com,
 dbassey@redhat.com, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 stefanha@redhat.com, manos.pitsidianakis@linaro.org, jasowang@redhat.com,
 Laurent Vivier <lvivier@redhat.com>, 
 slp@redhat.com, hi@alyssa.is, stevensd@chromium.org
Subject: Re: [PATCH v13 3/7] vhost_user.rst: Add SHMEM_MAP/_UNMAP to spec
Message-ID: <aagvbA7KPW8WtMha@sgarzare-redhat>
References: <20260219130334.787858-1-aesteve@redhat.com>
 <20260219130334.787858-4-aesteve@redhat.com>
 <CADSE00KJdqPp=mnC0zxPsZucWD+6-0zdiFM3XbZmSsTU1oMang@mail.gmail.com>
 <CADSE00+YH8LKdEWOy2edh6D2geaaGutN8X+pjkEhNmmgWj=M3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADSE00+YH8LKdEWOy2edh6D2geaaGutN8X+pjkEhNmmgWj=M3Q@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Mar 04, 2026 at 11:23:42AM +0100, Albert Esteve wrote:
>On Wed, Mar 4, 2026 at 10:46 AM Albert Esteve <aesteve@redhat.com> wrote:
>>
>> On Thu, Feb 19, 2026 at 2:04 PM Albert Esteve <aesteve@redhat.com> wrote:
>> >
>> > Add SHMEM_MAP/_UNMAP request to the vhost-user
>> > spec documentation.
>> >
>> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>> > Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>> > Signed-off-by: Albert Esteve <aesteve@redhat.com>
>> > ---
>> >  docs/interop/vhost-user.rst | 61 +++++++++++++++++++++++++++++++++++++
>> >  1 file changed, 61 insertions(+)
>> >
>> > diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
>> > index 17a68a62eb..ae4ad6f441 100644
>> > --- a/docs/interop/vhost-user.rst
>> > +++ b/docs/interop/vhost-user.rst
>> > @@ -350,6 +350,27 @@ Device state transfer parameters
>> >    In the future, additional phases might be added e.g. to allow
>> >    iterative migration while the device is running.
>> >
>> > +MMAP request
>> > +^^^^^^^^^^^^
>> > +
>> > ++-------+---------+-----------+------------+-----+-------+
>> > +| shmid | padding | fd_offset | shm_offset | len | flags |
>> > ++-------+---------+-----------+------------+-----+-------+
>> > +
>> > +:shmid: a 8-bit shared memory region identifier
>> > +
>> > +:fd_offset: a 64-bit offset of this area from the start
>> > +            of the supplied file descriptor
>> > +
>> > +:shm_offset: a 64-bit offset from the start of the
>> > +             pointed shared memory region
>> > +
>> > +:len: a 64-bit size of the memory to map
>> > +
>> > +:flags: a 64-bit value:
>> > +  - 0: Pages are mapped read-only
>> > +  - 1: Pages are mapped read-write
>> > +
>> >  C structure
>> >  -----------
>> >
>> > @@ -375,6 +396,7 @@ In QEMU the vhost-user message is implemented with the following struct:
>> >            VhostUserInflight inflight;
>> >            VhostUserShared object;
>> >            VhostUserTransferDeviceState transfer_state;
>> > +          VhostUserMMap mmap;
>> >        };
>> >    } QEMU_PACKED VhostUserMsg;
>> >
>> > @@ -1064,6 +1086,7 @@ Protocol features
>> >    #define VHOST_USER_PROTOCOL_F_XEN_MMAP             17
>> >    #define VHOST_USER_PROTOCOL_F_SHARED_OBJECT        18
>> >    #define VHOST_USER_PROTOCOL_F_DEVICE_STATE         19
>> > +  #define VHOST_USER_PROTOCOL_F_SHMEM                20
>>
>> Commit cda83adc62b6108afc8a82d0f54d9a9a861e7aa8 got upstream first and
>> took feature number 20, so this should be 21 now.
>>
>> @Michael Tsirkin Is it worth sending a new version or will you handle
>> the change?
>
>Sorry, I meant e0822e6085aecc15e2cfb2914d8cd827abae0249 (vhost-user:
>introduce protocol feature for skip drain on GET_VRING_BASE).
>
>But the question remains.

Maybe better to rebase to simplify Michael's life.

BTW this pach LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


