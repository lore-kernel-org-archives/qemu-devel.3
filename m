Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D8AECA5FA5
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 08:15:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCBwo-0001XY-Rx; Thu, 01 Oct 2026 04:15:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1xCBwn-0001XL-K3
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 04:15:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1xCBwl-0001u5-RH
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 04:15:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790842518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Exbble4a/qC9fRmpTft2k56GZbGZcUIHu9D8VD3eS3Q=;
 b=CiWl6mBuUFFB3Bf/LJhTjkQa6PD9O1/1Ig537NbwH34RB8UNcjotDNmrGaV2Hu2YYzhJ65
 7n+zjfpg9acqGSrtjJ48RXZ2SN2ghsRCEhy0awLduroLlHa2+RdQkNaMvHAPVpM3MWgZsB
 zEVrl4Gi9b/qfZZKW+dDg9Gdx5NAGj8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-Wisguec4OAiSaev9Sg-ItQ-1; Thu, 01 Oct 2026 04:15:15 -0400
X-MC-Unique: Wisguec4OAiSaev9Sg-ItQ-1
X-Mimecast-MFC-AGG-ID: Wisguec4OAiSaev9Sg-ItQ_1790842514
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49e65ecd557so41818385e9.1
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 01:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790842514; x=1791447314; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Exbble4a/qC9fRmpTft2k56GZbGZcUIHu9D8VD3eS3Q=;
 b=V//5ZKg9AOubHzjijMxeCvkAVM2ojVEhwktC12Jg32OnTwFVKswCdVwl30xCPXdnyW
 GemWAIhadUx4pQI0Zml0igMeNFsKMhrolIRNw2nwxSQtFKcEeTas328/nWFtLirRj69I
 WFeEymJzhM8+WjT0rCySN2/Vv39LpnCYdEk1Pj4CitoT/UJXDuLo/DKWNvUhBbimkJAu
 BQGSpq/+KnvWAlvxH6fkK3ZRFAnmtPbtbzj5uavmuMnpe2ZIXXI/KWAKeKqtP2SPGgcd
 z8Pdk5tfgK1GH3xYC4EeaUL/7PeLF0CQKPyxBnUmHsEiqKT8iRBcgTjMMu5xq00yc46f
 HUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790842514; x=1791447314;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Exbble4a/qC9fRmpTft2k56GZbGZcUIHu9D8VD3eS3Q=;
 b=Y5iss54ryF2iOLEcVW+YgW8rbETeaQ+7I8wzYCZmWo7zGTEJNVYIBt8GG5kqJ7POAo
 7fZ1iDlNmR+gVnwabYnAodxw8NfJFAHYBmYWozP64jUrVsXxo9FeQJM5PZt3ENhLL4FO
 wl1NH3BoqDMM/F8aXYom0eehNDFcOQsEp0zE1BRnzdh/hDbAgsfCMotlrEVBpTqUO2sa
 gxa5t3dZCNkP6cE2tHas3c2zIeaClLoH9pXmmwZQbDZsa2pk1JoOcmaWcMSglcCnoO5K
 E9w4sMASP6yeDI8HL2LLhztRhlzfZND5F67XQ63T2+zR30thPwoEcfaahfK8AenEHLn2
 kq/Q==
X-Gm-Message-State: AFuF++kK+tdfMYxx6ZmlJz8SarVzPcE/wDetdry8+wyfUWJzsIW7/lWo
 ug3FnvbFj+ztY+w38Mh8Goa62+eJ2SvD0+pwH1YBFMYRsSsOJWqHUVw3EcbCs+lT+bOCUPNjEgS
 vK6YvotQDY6cWcYoSXF6F1ir+TqXB4t+zCTEBbdjJESGs5eXBsw91xUHr
X-Gm-Gg: AYBFou3sflzyiwrqvox4Wtqf21E4j4UM1HvKSBEbX3jlIjhUT43GbL1JCagGXdchzau
 EsEGgZvJvD7lQfKgT8QKt9GUh7QAmWtkO4GmokrtuO2TUMglBIiAKhg0OJGQndnMClMNLD8OKzX
 lMa1o0EhVy/riECRF15mojxXtHVHREl+K7/7iFl6KjA1tIEXUNE6D4VHVn2QrXNWKRU80uit/oC
 NUuAUA9jMNIuRT50nuuZTh3TSD3twPYGTyL/EzYoIE9PB7UT2wnkBsh3zjNdfyC+odfuv1Ojk6U
 kPcGgyzOkGR2jszx9U2Nx4shM+2JBwtcO5p6/bXWQjHtKLBnhxliENC1BZEgvWZ4nFQ3r5yWb9q
 S
X-Received: by 2002:a05:600c:4f50:b0:4a0:dca:b78 with SMTP id
 5b1f17b1804b1-4a01b12b051mr82357515e9.27.1790842514439; 
 Thu, 01 Oct 2026 01:15:14 -0700 (PDT)
X-Received: by 2002:a05:600c:4f50:b0:4a0:dca:b78 with SMTP id
 5b1f17b1804b1-4a01b12b051mr82356905e9.27.1790842513960; 
 Thu, 01 Oct 2026 01:15:13 -0700 (PDT)
Received: from sgarzare-redhat ([5.77.112.40])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01f949709sm75952975e9.12.2026.10.01.01.15.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 01:15:13 -0700 (PDT)
Date: Thu, 1 Oct 2026 10:14:59 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, clg@redhat.com, mst@redhat.com, 
 maciej.szmigiero@oracle.com, dongli.zhang@oracle.com, bchaney@akamai.com, 
 philmd@oss.qualcomm.com, odaki@rsg.ci.i.u-tokyo.ac.jp, farosas@suse.de, 
 mark.kanda@oracle.com, dwmw2@infradead.org, peterx@redhat.com, 
 vsementsov@yandex-team.ru, den@openvz.org
Subject: Re: [PATCH v9 15/18] vhost: release ownership if vhost_dev_init()
 fails after SET_OWNER
Message-ID: <ar4U8CVaOih3EWT2@sgarzare-redhat>
References: <20260930-up-vsock-vhost-v5-v9-0-e9096f629770@virtuozzo.com>
 <20260930-up-vsock-vhost-v5-v9-15-e9096f629770@virtuozzo.com>
 <arziIHF39t15dVoc@sgarzare-redhat>
 <303b3f73-b263-492e-ab17-a0e2c49b3f09@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <303b3f73-b263-492e-ab17-a0e2c49b3f09@virtuozzo.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Sep 30, 2026 at 05:47:11PM +0300, Andrey Drobyshev wrote:
>On 9/30/26 2:58 PM, Stefano Garzarella wrote:
>> On Wed, Sep 30, 2026 at 01:13:14PM +0300, Andrey Drobyshev wrote:
>>> vhost_dev_init() takes the device ownership with VHOST_SET_OWNER and
>>> then may still fail, e.g. on virtqueue init.  Its cleanup only closes
>>> the backend fd, which doesn't release the ownership if the same file
>>> is open elsewhere.  That's the case on a CPR target: the source keeps
>>> the fd, and once it's resumed after the failed migration it can't take
>>> the device back, SET_OWNER fails with EBUSY.
>>>
>>> Release the ownership explicitly on the failure paths past SET_OWNER.
>>>
>>> Reported-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>>> ---
>>> hw/virtio/vhost.c | 10 ++++++----
>>> 1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> If you have to send another version, maybe better to move the
>> introduction of vhost_dev_reset_owner() in this patch since IIUC this is
>> the first place where we use it. (not a strong opinion)
>
>I'd still prefer separating them: one is pure API addition, subsequent
>ones #15 and #16 are actual functional change (also not a strong opinion
>here).

I usually prefer to avoid commits with unused functions, but I see your 
point, and this approach makes sense too, so I have no objections ;-)

>
>> That said, what happen if the caller of vhost_dev_init() fails after
>> calling it? Who will call vhost_dev_reset_owner()?
>>
>> E.g. in vhost_vsock_post_load(), if vhost_vsock_set_guest_cid() fails,
>> should we call vhost_dev_reset_owner()?
>>
>> Since IIUC all error paths call vhost_dev_cleanup(), might it make sense
>> to call vhost_dev_reset_owner() there?
>
>I think you're exactly right and it makes sense to issue RESET_OWNER
>directly from vhost_dev_cleanup().  Thanks for spotting the bug!
>
>By doing so, we obviously suggest that unconditional RESET_OWNER should
>be safe for any other non-CPR case.  In particular, on the cleanup path
>we call
>
>vhost_dev_cleanup() ->
>  hdev->vhost_ops->vhost_cleanup() ->
>    vhost_kernel_cleanup() ->    // kernel backend
>      close(vhostfd)
>
>So backend FD is being closed either way.  IMHO that alone should be
>enough to assume that resetting owner for any vhost-backed device is
>safe.  Please correct me if I'm wrong here.

Yeah, it seems correct to me too.

If we want to be more cautious, we could pass a parameter to 
vhost_dev_init() (or add a new function that calls vhost_dev_init) to 
store a variable in vhost_dev that indicates whether the device supports 
CPR, and decide whether or not to call vhost_dev_reset_owner() during 
cleanup. But again, I think we are fine calling vhost_dev_reset_owner() 
unconditionally.

Thanks,
Stefano


