Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33DBFCD37B6
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 10:01:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN6Nv-0005tK-KY; Wed, 13 May 2026 06:00:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wN6Nk-0005q8-1U
 for qemu-devel@nongnu.org; Wed, 13 May 2026 06:00:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wN6Ne-0005Ef-Ci
 for qemu-devel@nongnu.org; Wed, 13 May 2026 05:59:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778666392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qUqW8p9+rFcb0BrXm7mCeMxCemBEz8wDpu9wCfKM5TQ=;
 b=NuUpokfa83LigJW/UlM08YOAPphr6PQm4F26K7R+qqu/v1O5rKlwc6aLDgK4ii205/XzMc
 1/YRY0jYoH9lzxTxsGLTkdf/H8ohz9zqCbzaZezm7aoz2wji1UPgtMPXv5F4DqcbM0+eNB
 339PYyQD3oU8fh1DaP0VEoVhohuKODA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-ojSAELOaOAOfJPCmwv1MUQ-1; Wed, 13 May 2026 05:59:50 -0400
X-MC-Unique: ojSAELOaOAOfJPCmwv1MUQ-1
X-Mimecast-MFC-AGG-ID: ojSAELOaOAOfJPCmwv1MUQ_1778666390
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-43efc93e4f6so4305089f8f.3
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 02:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778666389; x=1779271189; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qUqW8p9+rFcb0BrXm7mCeMxCemBEz8wDpu9wCfKM5TQ=;
 b=LbYyJ0IKhvOjlHo5ebqtxlVok5XLk9qwg8knm+Jjxk2ZRxi3HpY/Z7y29R7ck38yZX
 MSJ3owvjpPBll6hbYfMilfDD0BMrVCZDoUSovKVVKVMclrKORyIHuBKlZcZUmghV3b/2
 RA1aD8CYI2zL/iOQu36MKtJb4BBUzYIBE5Db6erx2PxzR36FPVatPlzUZdWGQ39/toa7
 rIq3CjW7SwlhT/CpPS2HBT319ONHDqYiUIzbec4DiSzdtEFTa4PSU2xobPp915m7S69k
 Em1CZFyyVBhER0E01Vmn8H4gierLu0UcwKkiDHbXt1t5Mj9Hx30VJFbkBK8ipMmlHhhT
 Se1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778666389; x=1779271189;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qUqW8p9+rFcb0BrXm7mCeMxCemBEz8wDpu9wCfKM5TQ=;
 b=LTIV5PuOnKKzO+XIPsKVjJyrH/ZckiNUwCHH5rZpe+dBf2E7F9sW4JUDRagxAJvJDN
 EJQ55KTftsgi0Gewzl7kWqePb4pmmfJspEMw/hp4k3EMKJTQ60ODSrmUHuamqOwQCNbv
 XezYNqtAJpEpPYESR6I1dDHzhMQu5jzZj8gpyVd2AIOQDVNLql5FVyasnyKoufzbZ6OI
 BrhP+5EpAIsdHxRuohO1pHhxxuyD2JzQj0oAGabYvXieHd2UbDY5H2uX25WvkJEL2ntm
 nXkH1jv4ImHsaZ0cEwoyhlF5kNQoOUvDWTaheMecpo6eLrHEb7Jj2THsYBDHgEc7x4l4
 AY+w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/KcPyxPeeZRwvTsdyxzLGVvHD2DveYr4R3MmASEQ6/CmsitZGnTFLGPQ/zobhzDj2lo9BBOkgoVSHZ@nongnu.org
X-Gm-Message-State: AOJu0YzF9cA4aRaHbRCoZ/YiE3so5uz8mA4ZKZdWwn3bjJoGW6sQ4Jbi
 laK1rr0BjCev4n2ux7pAc6imiO7fINcBvZoIdr0SZx2ZuOFLU6YyopS3hHF4z9A0K/ixzqfowSk
 M/pW/2opZ1ytmZllHmVlLWAz0eCa7jsfmItRKRNp+IxPSt9CvjI+hHajo
X-Gm-Gg: Acq92OFXFt1DVfMevoOzZceDIuh8s1zuaRwsF+XBKBM6uP61iXX84n+yjSSYVPaPaD0
 +df6CAVnkjRN92XdJAPZsQaEch7G8H9v4sCSFgkxPcbNDGYcKYbXMa9EC5+Ub66nuwdjVEHXZ+v
 KnVNb4ZWr5rv6GwjkMWjg5i7nEL1RZQWuQ8ph10ya3evqASeFgtgKhXWKavX53gjwXkFzolAIQT
 gyFeMhP1tOD8TAcqsWRX5vf2ViLqqdE7JD+9TiUD4e62j9VOoVMEk/1dvBnGZ71brt9EsJlqXZY
 65bGAIeQOZt8EwQ3i9IQj5pyEDnsMMrBE+JhCiS2EKD1RI/7XwdOarwkM+v8LCd0LIUtA0J7CvJ
 sdA+uBXcUo3NtdhFst/2RN0Jj3DbjU9OowkgnU+9+
X-Received: by 2002:a05:6000:2481:b0:43c:f8b4:e58 with SMTP id
 ffacd0b85a97d-45c59cd02b9mr3725678f8f.41.1778666389461; 
 Wed, 13 May 2026 02:59:49 -0700 (PDT)
X-Received: by 2002:a05:6000:2481:b0:43c:f8b4:e58 with SMTP id
 ffacd0b85a97d-45c59cd02b9mr3725602f8f.41.1778666388774; 
 Wed, 13 May 2026 02:59:48 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4548ec6aea4sm45592325f8f.10.2026.05.13.02.59.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 02:59:48 -0700 (PDT)
Date: Wed, 13 May 2026 05:59:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Junjie Cao <junjie.cao@intel.com>, qemu-devel@nongnu.org,
 jasowang@redhat.com, yuri.benditovich@daynix.com,
 berrange@redhat.com, peter.maydell@linaro.org, qemu-stable@nongnu.org
Subject: Re: [PATCH v2] virtio-net: validate RSS indirections_len in post_load
Message-ID: <20260513055917-mutt-send-email-mst@kernel.org>
References: <20260324060100.1997-1-junjie.cao@intel.com>
 <f4e8921d-d1fb-4ff6-95d2-de6b44a5941e@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f4e8921d-d1fb-4ff6-95d2-de6b44a5941e@tls.msk.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, May 13, 2026 at 09:42:59AM +0300, Michael Tokarev wrote:
> On 24.03.2026 09:01, Junjie Cao wrote:
> > virtio_net_handle_rss() enforces that indirections_len is a non-zero
> > power of two no larger than VIRTIO_NET_RSS_MAX_TABLE_LEN, but
> > virtio_net_rss_post_load() applies none of these checks to values
> > restored from the migration stream.
> > 
> > A corrupted save file or crafted migration stream can set
> > indirections_len to 0.  Even if it also clears redirect,
> > virtio_load() calls set_features_nocheck() after the device vmstate
> > (including the RSS subsection and its post_load) has already been
> > loaded, re-deriving redirect from the negotiated guest features.
> > When VIRTIO_NET_F_RSS was negotiated, redirect is set back to true
> > regardless of the migration stream value.  The receive path then
> > computes
> > 
> >      hash & (indirections_len - 1)   /* wraps to 0xFFFFFFFF via int promotion */
> > 
> > and uses the result to index into indirections_table, which was not
> > allocated by the VMState loader when the element count is zero (see
> > vmstate_handle_alloc()), resulting in a NULL pointer dereference that
> > crashes QEMU:
> > 
> >    #0  virtio_net_process_rss    ../hw/net/virtio-net.c:1901
> >    #1  virtio_net_receive_rcu    ../hw/net/virtio-net.c:1921
> >    #2  virtio_net_do_receive     ../hw/net/virtio-net.c:2061
> >    #3  nc_sendv_compat           ../net/net.c:823
> >    #4  qemu_deliver_packet_iov   ../net/net.c:870
> > 
> > The RSS subsection is only loaded when rss_data.enabled is true (via
> > virtio_net_rss_needed()), and the command path always produces
> > indirections_len in {1, 2, 4, …, 128}, so an unconditional check
> > cannot reject a legitimate migration stream.
> > 
> > Factor the validation into virtio_net_rss_indirections_len_valid()
> > and call it from both virtio_net_handle_rss() and
> > virtio_net_rss_post_load().
> > 
> > Fixes: e41b711485e5 ("virtio-net: add migration support for RSS and hash report")
> > Cc: qemu-stable@nongnu.org
> > Signed-off-by: Junjie Cao <junjie.cao@intel.com>
> 
> Hi!
> 
> Has this patch been forgotten, or is it not needed anymore?
> 
> I'm preparing next set of the stable qemu releases, if it's needed,
> it would be nice if it lands in the master branch in the next 10
> days.
> 
> Thanks,
> 
> /mjt

I'll pick it now, thanks.


