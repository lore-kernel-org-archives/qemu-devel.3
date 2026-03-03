Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 634D3EDEBF1
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 20:28:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxWKw-0001Tk-Ah; Tue, 03 Mar 2026 15:27:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxWKs-0001So-KG
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 15:27:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxWKq-0008Ve-FD
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 15:27:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772569634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KhHWeIHx6PBaZnfFcmqNEOBqnPdBYa4kH3IQHIX7oZo=;
 b=OQGvLbsaqB+teaqQo7TGCRjJ3Blff8vHzaBHZgeL+kp+W5EhoRt9bUqS5OhJxXvlJBfnq5
 rJHQTXnAUeHsdQxYHhxZzS8Eu/yI/MOWEO2AeWc0/jsJZyBeqgpLPw/BKkCAwPXausR35R
 MJSV1GfrMZckft1zRIU28NA0BWYZMHM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-1VHgEqH7NkqN1uvMdT0vIg-1; Tue, 03 Mar 2026 15:27:13 -0500
X-MC-Unique: 1VHgEqH7NkqN1uvMdT0vIg-1
X-Mimecast-MFC-AGG-ID: 1VHgEqH7NkqN1uvMdT0vIg_1772569633
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8ca3ef536ddso864223185a.0
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 12:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772569633; x=1773174433; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=KhHWeIHx6PBaZnfFcmqNEOBqnPdBYa4kH3IQHIX7oZo=;
 b=d+KQU8oUbOScGOUtSoL14E3wmxV2CW8lxOdyYMuUJeqWRf8LYIjW62osAz1awxw/X9
 dGJN2+zyZDv0nRdgsAC612BZ+eqgT1Ja0K5CINEPscA0GM2aAQ4bq8415S1749azRqlO
 1Qfj23NvI/RlRSod115oehsL5QDCi80KC5FLV7eIkEExRDdr0GvpW+ome40uT+5UftLA
 JvSB6hTU4N1C7WWYrmMrsj6VxO6JQxuyUsXVZFAuH1tcBbvhYUH0TXBDWyATS7H9v0OU
 1zKTcV+35nFpppNZGqf4WHKwNcrHkz5z/wHfYrvkdrr7n/x2t7hjgWVnGEBXT5MQrrTW
 ZsBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772569633; x=1773174433;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KhHWeIHx6PBaZnfFcmqNEOBqnPdBYa4kH3IQHIX7oZo=;
 b=aYv/ubG20Sq2V2MrE7SGGVQAsX/Vk73JZkRbrR8zICUK34hrkAm+IBrM2o5gjLdsip
 Jb43EaZT7ERonVc/mdutDTUX1/18xcwzh9Ej1GLu4Mv93B3U4bpYOeKuA3toogV0cPGS
 pZLdAHfuYbeZBIEcytrTMoyFZztpWYpK8kKnqzV6bqLQB2QS0qG1kdUE35y66aAAgCqF
 cti6T0dX1A5KvgO+AtgFNnbyC51ULzdZFZZYZMx2Acq6CsFguGjJAP+cM4iWIW1/3+CB
 8qY7SErxRPQAnupyEreFQjeW8j3AMGze0BN6ZwEyxhDawBlZxdojzPlvI8P4YRFlLp5G
 /Bkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxECb1bS2pIscugStwg3WrANc3GM+POXT2iuIsigSLxHcjJZbI1uEM/fYyKLv84XFTBVDPpwKhT5gZ@nongnu.org
X-Gm-Message-State: AOJu0Yz/f9YeDgr5QvNc0OW4i/FzkwZEHMylik4YwAlf5QLT5zIbT/Kg
 TyEJ0/40PK0xZ5EMIoNW+q3VHKZ+gr71oas3Zwdmz+aAMaIg3rhIg/CqQgbko2EpiBvlAU9Aanw
 jShnWXlW843Tl/+cpQva1wsSDDmExB+9pPveSSV45nCy54z+TpkV+Al6/
X-Gm-Gg: ATEYQzyfzQvMOYRHfSN73vF3w1WvdB3tCNhc+93SE6mJ67jVoKV841ARP+wt5S7u2+R
 CPmJYR3NTDk9zSw1q5p+WdouJkVK1Zc3WCKmr+NDbt0+3qFNfvdhx8HWxxwQI616ZcI0PcwLOGZ
 kGnA07NnYlLBGaEe7TvSl5w5tiEAd2q0g3VKPsmNHjAnpUR2H/ifeozu4969yx0pGFqbLtnnIf0
 sbxCecFi6gQwgIa0s0Aw62JnwrlHzAc6jx+JZq8s0uGn7JECvaGf4BIJvcjinkGKEiGKCWGhc40
 RQFV9ffrMOQeHWS60XiVuD3DaM3rtlTTtldFvWhIGPmYnFtBUSbJYxvh70OY7LxLDQZykcnEs8K
 Yv9hj/EDGi2VqhA==
X-Received: by 2002:a05:620a:711a:b0:8cb:3a1d:79fa with SMTP id
 af79cd13be357-8cbc8e1fc02mr2326810785a.58.1772569632634; 
 Tue, 03 Mar 2026 12:27:12 -0800 (PST)
X-Received: by 2002:a05:620a:711a:b0:8cb:3a1d:79fa with SMTP id
 af79cd13be357-8cbc8e1fc02mr2326806485a.58.1772569632083; 
 Tue, 03 Mar 2026 12:27:12 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf6592desm1466684585a.2.2026.03.03.12.27.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 12:27:11 -0800 (PST)
Date: Tue, 3 Mar 2026 15:27:00 -0500
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: David Hildenbrand <david@kernel.org>, qemu-devel@nongnu.org,
 Ben Chaney <bchaney@akamai.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex@shazbot.org>, Fabiano Rosas <farosas@suse.de>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Mark Kanda <mark.kanda@oracle.com>
Subject: Re: [PATCH v3 09/15] system/ram-discard-manager: implement replay
 via is_populated iteration
Message-ID: <aadEFOLPsRjWTcfX@x1.local>
References: <20260226140001.3622334-1-marcandre.lureau@redhat.com>
 <20260226140001.3622334-10-marcandre.lureau@redhat.com>
 <99b0ab59-c1dc-4d23-addc-7bf4b87bfa03@kernel.org>
 <CAMxuvazwmjjpnpsWpOd_=HcS-6ynpVjAw2u3R=VuE=Lhg=AnKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMxuvazwmjjpnpsWpOd_=HcS-6ynpVjAw2u3R=VuE=Lhg=AnKw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
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

On Tue, Mar 03, 2026 at 11:47:52AM +0100, Marc-André Lureau wrote:
> We can still iterate with 2M granularity after this patch. However, it
> may be less effective than iterating using find_next_bit(). Whether
> this is noticeable remains to be seen.

IIUC when in extreme scattered cases the results should be similar, say,
when the bitmap (2M for each bit) is 10101010....10101b. OTOH the worst
case scenario here is when e.g. the whole region is fully populated.

So.. if we have any concern, maybe we could run a VFIO population test on
non-CoCo, before or after this patch, having the whole region requested
available (so a bitmap with 111111111....111111b).

Thanks,

-- 
Peter Xu


