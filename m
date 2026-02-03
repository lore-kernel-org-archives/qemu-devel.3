Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6864E6E80D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 11:08:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnEGB-00072k-FU; Tue, 03 Feb 2026 06:07:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vnEGA-00072T-88
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 06:07:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vnEG8-0001CI-9O
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 06:07:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770116869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pDgUn6tbHFeagrg1NPJ07bErHz+TI0uK1hM6G/flgPg=;
 b=g7+VihaoXxteo1u3R+s/m8cjfOYynZKQS52e9yFwHHrC1JLmiLamEw+KINotRsSCrJ6ZNp
 QvVv0krAWtPIQNuesaggjc9K38xL4EC7L4g7Ipsyw158AzhHEP/azWMTgFVop5po0qjkAW
 l2ma68b0WegCQgzM9P/xx3C3DObVtoY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-9cEu3m4CM4OnvtAbT5kz3w-1; Tue, 03 Feb 2026 06:07:48 -0500
X-MC-Unique: 9cEu3m4CM4OnvtAbT5kz3w-1
X-Mimecast-MFC-AGG-ID: 9cEu3m4CM4OnvtAbT5kz3w_1770116867
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-480711d09f1so74581315e9.0
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 03:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770116867; x=1770721667; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pDgUn6tbHFeagrg1NPJ07bErHz+TI0uK1hM6G/flgPg=;
 b=Itn2kIVxdpbvzam0B1AbtuQCKaKfuAEgbMv0ceJWrZ5f1sgwPGIv896JcvpqYTFGw8
 B9yY2IIMC8o2k1vE1rJG2HbIq+fUfBeXXXdco+Nxtsuq0CnojeSkVdtI/2H2slJFld0E
 4PTwUlmS4A67+MTmj+E0y8iSmGwm6IxwuzzQcowMBYYdW1Mfzp2JIOzztxUiI7fs0apq
 tXORZ2Ame4t6I6Z8lxbHGFpWPzJX5OjtT9hTsg9suhGJ80dSpNwfPBPI3NvztYxs44iG
 SMLzd8gY6LarrIuAl9ojbMkj7DWOhmVWnJCGM1SOQmjcCvzoi9Ub7DKviZmWzWGzs+Km
 Vbpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770116867; x=1770721667;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pDgUn6tbHFeagrg1NPJ07bErHz+TI0uK1hM6G/flgPg=;
 b=Gua49nmKxL5Z2UivJChCCXXTHDbJX7hDkvSbMMg6qaxLEsAIiKxIi34cMi6zYx18rE
 2y38VQMN32HtoE9Srqgf5Kxj7xDLCsAe1BUzUeXcq4h2CsB3A49NtHWOAP7y88BnV6NM
 ZYE1bPNac4Ey/0jw8GK+aKy+7EOg14C98gdYu/pBKiTPnHy6CKfIFvj3SCdVCefRCIzX
 o5YyiYXbQ2Md1PXpDP8FjXhsSboBq54I3tQWA413oGU70Z72hUy/UXWnLUHT4Jq0hqhc
 mMlGvziOx0Xt51bKnyFn5qCv1SWHAeWQYbpwUnrklwlNTQiVd3eeO/5QAqTZNWRH9IVy
 8hAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVj3LreUHOxEKT6VyUBeuUPFlKpaybVNxErn+ArJlT0aF4IQ4AYdvfd94raEzliUHfjPxJmdiAIIhQX@nongnu.org
X-Gm-Message-State: AOJu0YyW/44uxdEhTqQQfy+9rTZVgqwnXZkaPiL9O0V79hdV+PeTd48K
 W113pzIbO7tyhaLCvql6Ybn2LtEAjWj4oF+I4VJJw/WM0VnMrYgH3WtOWDFhNZ/dgx8mNy6nl+h
 yCMxs6YbUEBANKN3KaDwsMLLn3D09bYcidFrkgmAiaQ6G5B+GpVIVSOh+
X-Gm-Gg: AZuq6aIaf0l2T8sO8ehl1ZsJARi7ym2BbRiUqErLKr4cs/fgrvEnAq6Q2slaPHGubqD
 xCK5rERCJdo/ZKoyUC63h3fTtQAICOJOIetp7RLsOMvEtSlHfKTRCCzMt4/Hav3ZJUsqHjVH9+U
 dS0AtGLebzx2a60IHeJqYIE6Krc6mz28lRFdwAk5aof635xgGv289py1hB2AdYnkj8jUx3s9WGE
 ezl30bsHH1o1p+/ST2BRPlHXCGT3N9/RTLPdlpvgS8R8zDNlXynSzCVJ6byHJkOGmLkzt6Yxh+m
 I0ocoHtimvGsto/cZwas55nZglXDVFmM3Uz1jvh6nJRILKbq9YCs+W3z21G3us7Lf5oOi/tRcm9
 hMeHjF1vdNGjX8QWoLTPwCnaHXJ3slTaGQw==
X-Received: by 2002:a05:600c:c4a3:b0:480:6c75:ddce with SMTP id
 5b1f17b1804b1-482db49da16mr214525405e9.33.1770116867341; 
 Tue, 03 Feb 2026 03:07:47 -0800 (PST)
X-Received: by 2002:a05:600c:c4a3:b0:480:6c75:ddce with SMTP id
 5b1f17b1804b1-482db49da16mr214525055e9.33.1770116866882; 
 Tue, 03 Feb 2026 03:07:46 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-482db623407sm149007335e9.0.2026.02.03.03.07.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 03:07:46 -0800 (PST)
Date: Tue, 3 Feb 2026 06:07:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Subject: Re: [PATCH v3 04/11] hw/virtio: Use
 VirtIODevice::access_is_big_endian field
Message-ID: <20260203055247-mutt-send-email-mst@kernel.org>
References: <20260201232924.93399-1-philmd@linaro.org>
 <20260201232924.93399-5-philmd@linaro.org>
 <20260202024316-mutt-send-email-mst@kernel.org>
 <87bji7pa2e.fsf@draig.linaro.org>
 <20260202105847-mutt-send-email-mst@kernel.org>
 <20260202185233.GC405548@fedora>
 <1c0fc67a-1ded-4200-b9d0-e20a06cb5b4b@linaro.org>
 <1804511f-a048-4eb8-9cf3-1c75bdf4b277@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1804511f-a048-4eb8-9cf3-1c75bdf4b277@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Feb 02, 2026 at 07:22:16PM -0800, Pierrick Bouvier wrote:
> On 2/2/26 11:25 AM, Pierrick Bouvier wrote:
> > On 2/2/26 10:52 AM, Stefan Hajnoczi wrote:
> > > 
> > > This command-line lets you benchmark virtio-blk without actual I/O
> > > slowing down the request processing:
> > > 
> > >     qemu-system-x86_64 \
> > >         -M accel=kvm \
> > >         -cpu host \
> > >         -m 4G \
> > >         --blockdev file,node-name=drive0,filename=boot.img,cache.direct=on,aio=native \
> > >         --blockdev null-co,node-name=drive1,size=$((10 * 1024 * 1024 * 1024)) \
> > >         --object iothread,id=iothread0 \
> > >         --device virtio-blk-pci,drive=drive0,iothread=iothread0 \
> > >         --device virtio-blk-pci,drive=drive1,iothread=iothread0
> > > 
> > > Here is a fio command-line for 4 KiB random reads:
> > > 
> > >     fio \
> > >         --ioengine=libaio \
> > >         --direct=1 \
> > >         --runtime=30 \
> > >         --ramp_time=10 \
> > >         --rw=randread \
> > >         --bs=4k \
> > >         --iodepth=128 \
> > >         --filename=/dev/vdb \
> > >         --name=randread
> > > 
> > > This is just a single vCPU, but it should be enough to see if there is
> > > any difference in I/O Operations Per Second (IOPS) or efficiency
> > > (IOPS/CPU utilization).
> > > 
> > Thanks very much for the info Stefan. I didn't even know null-co
> > blockdev, so it definitely would have taken some time to find all this.
> > 
> > For what it's worth, I automated the benchmark here (need podman for
> > build), so it can be reused for future changes:
> > https://github.com/pbo-linaro/qemu-linux-stack/tree/x86_64_io_benchmark
> > 
> > ./build.sh && ./run.sh path/to/qemu-system-x86_64
> > 
> > My initial testing showed a 50% slow down, which was more than
> > surprising. After profiling, the extra time is spent here:
> > https://github.com/qemu/qemu/blob/587f4a1805c83a4e1d59dd43cb14e0a834843d1d/target-info.c#L30
> > 
> > When we merged target-info, there have been several versions over a long
> > time, and I was 100% sure we were updating the target_info structure,
> > instead of reparsing the target_name every time. Unfortunately, that's
> > not the case. I'll fix that.
> > 
> > With that fix, there is no difference in performance (<1%).
> > 
> > I'll respin a v4 with the target info fix, initial v1 changes and
> > benchmark results.
> > 
> > Thanks for pointing the performance issue, there was one for sure.
> > 
> > Regards,
> > Pierrick
> 
> After proper benchmarking, I get those results (in kIOPS) over 20 runs, all
> including target_arch fix I mentioned.
> 
> reference: mean=239.2 var=12.16
> v1: mean=232.2 var=37.06
> v4-wip (optimized virtio_access_is_big_endian): mean=235.05 var=18.64
> 
> So basically, we have a 1.7% performance hit on a torture benchmark.
> Is that acceptable for you, or should we dig more?
> 
> Regards,
> Pierrick

Could we use some kind of linker trick?
Split just the ring manipulation code from
virtio.c and keep it target specific.


Or it could be that even just these two would be enough:

static inline uint16_t virtio_lduw_phys_cached(VirtIODevice *vdev,
                                               MemoryRegionCache *cache,
                                               hwaddr pa)
{
    if (virtio_access_is_big_endian(vdev)) {
        return lduw_be_phys_cached(cache, pa);
    }
    return lduw_le_phys_cached(cache, pa);
}

static inline void virtio_stw_phys_cached(VirtIODevice *vdev,
                                          MemoryRegionCache *cache,
                                          hwaddr pa, uint16_t value)
{
    if (virtio_access_is_big_endian(vdev)) {
        stw_be_phys_cached(cache, pa, value);
    } else {
        stw_le_phys_cached(cache, pa, value);
    }
}






-- 
MST


