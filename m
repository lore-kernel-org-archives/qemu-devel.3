Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A62E1CAC59A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 09:10:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzX7n-0006TN-J0; Fri, 19 Sep 2025 05:09:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uzX7m-0006T2-HZ
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 05:09:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uzX7k-00057F-II
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 05:09:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758272986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yGa3323VyoXzC8YR3zQR4fMcIPxBBwfcgFJuXAAhf7c=;
 b=Uio2c9UZgrn24yrLn7KDVCDCC2Pevulsd7oC3aZX8dnm+E0RjFWcvEOf1CsdYsuD42n464
 leFsUv4aQ/TMXIEIuzQlNEugRt1o0cvTTGogcF2Zt31CcCB1g4VSfgbi+yi4VxoB0u4jdo
 z2oCXNSTr37/MhLioo9dSWg6Gmz0Hik=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-pk4cfufMOGykw48REsmXuw-1; Fri, 19 Sep 2025 05:09:42 -0400
X-MC-Unique: pk4cfufMOGykw48REsmXuw-1
X-Mimecast-MFC-AGG-ID: pk4cfufMOGykw48REsmXuw_1758272981
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3ecdf7b5c46so691911f8f.2
 for <qemu-devel@nongnu.org>; Fri, 19 Sep 2025 02:09:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758272981; x=1758877781;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yGa3323VyoXzC8YR3zQR4fMcIPxBBwfcgFJuXAAhf7c=;
 b=To3VB5uY4G73m4LuNfvijnbZNA+RTu57oeZFlIV/H0bQTThlSexRHwfJoTV4FOMtwl
 8CWif+6T7J0vFZJInNfo/eOeFK4kQoORS1PWRE+/Hi4c4V0WLiHz60HmBPlGwoPfEwH7
 oYquHdOJawQOdz3q6tWhS1/lhxZXe7wcFkvsj8wopHKIeS+jEVZ+5vqCblnrspUz+SeN
 JnVo4Y8Gg671fFQhxvF89IaJvwq0NoEHcJyudDNcyI6RM8l3rONmWEGJArt3L5h8UFFx
 wmXt2UxMr9BUC9V69721yHFsLh6fB+80W082ANhzWOX86z4/OsDSZwmYKOx+mbbUQ5CF
 iJ1Q==
X-Gm-Message-State: AOJu0YzqrDyXxhP2AcAK/abTjVSGFGqdYJNdxz1Fs6zOo2/TfAiTXlnk
 U8UdNhjmOPXYnKk1CF5Cw2Gur14CrTX8i0WGSetXiw0QS1F1NWQJwPFl1FDZDRrcamiCCsISsUG
 3G0p2HS7L1IROLg+++BQceq92pipnUJFM1Nwnez1E3rFOctelEDEhqvi52On8nHCY
X-Gm-Gg: ASbGncuD54c/8ahbta5mkE+cygo16UB3rj02eJu2GYL0rJrJ4O1gExRchDa+ZIoulIe
 Jux6kMmkEM3raAV3FYdcrMstMnXGJ0xowYd7FknfEMXvQGrplQQZLuK0X3lb4i6pErTNGL/IMLA
 +CrNXaNolVtn5IeiojkH6Hk/G5p4HnXzQDDSENdXE+TXk3U/T0m4bI8yX7iE8XZlx5I1nhWpW6N
 srGPhS6ReI5ChMwY546lDI/axRMDzCOgAUL4a7aCX/uQDzS8Cgu9XM43YkrznC0lnuLlFOe0gSp
 8dYfqdeXm9WajRSEx94i+SjU2f6oDel2ar7u7gJTXsccgFiGe3getiYw/MR/4VKDiA/OtNBDxHi
 V5fOF4HxNo1MZ
X-Received: by 2002:a05:6000:26c6:b0:3ec:d7eb:7d30 with SMTP id
 ffacd0b85a97d-3ee861f839bmr1676210f8f.49.1758272981092; 
 Fri, 19 Sep 2025 02:09:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/X4/ufWBs+McaP7BFFXHHAaezQ4DUWyt56kK9II2XFwM92+lfpS9+y9/A3CDXWVMM/i8t5w==
X-Received: by 2002:a05:6000:26c6:b0:3ec:d7eb:7d30 with SMTP id
 ffacd0b85a97d-3ee861f839bmr1676185f8f.49.1758272980590; 
 Fri, 19 Sep 2025 02:09:40 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c?
 ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-464f4f9f4e4sm87848775e9.13.2025.09.19.02.09.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Sep 2025 02:09:40 -0700 (PDT)
Message-ID: <833f3184-1bda-4761-9657-77ac73f01135@redhat.com>
Date: Fri, 19 Sep 2025 11:09:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/14] virtio: introduce support for GSO over UDP tunnel
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Luigi Rizzo <lrizzo@google.com>, Giuseppe Lettieri
 <g.lettieri@iet.unipi.it>, Vincenzo Maffione <v.maffione@gmail.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Lei Yang <leiyang@redhat.com>
References: <cover.1757676218.git.pabeni@redhat.com>
 <CAPpAL=yfdoDzXZw+JPAfGym9me=9a+u5p97xAzJyn_VJXJTBYA@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAPpAL=yfdoDzXZw+JPAfGym9me=9a+u5p97xAzJyn_VJXJTBYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pabeni@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.005,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Michael,
On Fri, Sep 12, 2025 at 9:10 PM Paolo Abeni <pabeni@redhat.com> wrote:
> Some virtualized deployments use UDP tunnel pervasively and are impacted
> negatively by the lack of GSO support for such kind of traffic in the
> virtual NIC driver.
>
> The virtio_net specification recently introduced support for GSO over
> UDP tunnel, and the kernel side of the implementation has been merged
> into the net-next tree; this series updates the virtio implementation to
> support such a feature.
>
> Currently the qemu virtio support limits the feature space to 64 bits,
> while the virtio specification allows for a larger number of features.
> Specifically the GSO-over-UDP-tunnel-related virtio features use bits
> 65-69; the larger part of this series (patches 4-12) actually deals with
> extending the features space.
>
> The extended features are carried by fixed size uint64_t arrays,
> bringing the current maximum features number to 128.
>
> The patches use some syntactic sugar to try to minimize the otherwise
> very large code churn. Specifically the extended features are boundled
> in an union with 'legacy' features definition, allowing no changes in
> the virtio devices not needing the extended features set.
>
> The actual offload implementation is in patches 13 and 14 and boils down
> to propagating the new offload to the tun devices and the vhost backend.
>
> Patch 1 is a small pre-req refactor that ideally could enter the
> tree separately; it's presented here in the same series to help
> reviewers more easily getting the full picture, patch 2 updates to
> linux headers update script to deal with annotations recently introduce
> in the kernel and patch 3 is a needed linux headers update.
>
> Tested with basic stream transfer with all the possible permutations of
> host kernel/qemu/guest kernel with/without GSO over UDP tunnel support,
> vs snapshots creation and restore and vs migration.
>
> The new features are disabled by default to avoid compatibilty issues.
> They could be enabled with a later patch, together with the related
> compatiblity entries.

Does this iteration solve the merge issue? Any other action needed on my
side?

Thank you!

Paolo


