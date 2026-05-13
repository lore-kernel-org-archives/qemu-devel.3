Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DDE9CD37AC
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 20:37:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNGKx-0007PY-P4; Wed, 13 May 2026 16:37:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wNGKh-0007MG-KZ
 for qemu-devel@nongnu.org; Wed, 13 May 2026 16:37:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wNGKb-0000yF-3f
 for qemu-devel@nongnu.org; Wed, 13 May 2026 16:37:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778704642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DWfXX+fJ6A281I+ei1nLQPjL7UvbuHtA3kTyRclOLOE=;
 b=F2NMsRqJT4d7ppOxjXHg5+fONlbpLF0B77APAwLBzKQNJ5+GHcvjFrXth1yAOAcvPNK3kk
 wBS2APuGpyVlXhORkG/opg8C4eQlNaUnyvTcpYvmmuusKp4IBupX5NtuCbgwdtN1RFmGjh
 Ygpxvb/HLHakGBd6uUAZnWI9H4uUvoc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-ytlkwqY6PEyuGFsuVi8MIA-1; Wed, 13 May 2026 16:37:19 -0400
X-MC-Unique: ytlkwqY6PEyuGFsuVi8MIA-1
X-Mimecast-MFC-AGG-ID: ytlkwqY6PEyuGFsuVi8MIA_1778704639
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5104b861649so218650861cf.1
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 13:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778704639; x=1779309439; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DWfXX+fJ6A281I+ei1nLQPjL7UvbuHtA3kTyRclOLOE=;
 b=JGReN97ylroJM5XHYduLB2Kb37DO9JJwGvwEv/TqcpGSdP6XI5GCjMlDSlbV1us/hR
 eR0XNjKQA74nmcUyt5U3SgAgyYo6wyntkXnAEXkb0pIioWds7fCrFg9j8ecVlaNtROJQ
 QlXth4dGjLtdYIm3l0cfwI5umwGieGaOgytz+GCkMY/IhQJJK+Uk+7es8JRiUs8sbzf2
 261ROwRCpgKjXiJZW3Q4QTQnx2Q0XC2J6hzA7Uzujs31DlkxpNN/lX/p14g3xQXJN5Yw
 eoAA5a2ox4dNMBJRQSVOL6xK4o3ZtyQdcLAsXWSsNSn1cI1YbKfw8E+II0LptA7ZYLAU
 GQSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778704639; x=1779309439;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DWfXX+fJ6A281I+ei1nLQPjL7UvbuHtA3kTyRclOLOE=;
 b=NM4MvGNBWSu/ToCDXn54hZ6tUGxT8WKgkXoitrkVZ7+WKIjtmJ5dqlgLsfWlzYTqc8
 PA8jVWazmn9Az139Eq587EIPQoCTPdedJfnnTC2ZfQEKru2reAywbyzZ+w+fWgtFUvSp
 m+M7erNXT/oEtqW6h6QhWcvJ3DNURBW5Z7LNecOHds5DrKxcms1ZvDoGZ0MLQqJ+cRzY
 lTWwEJ6G7ofOJGLeAaGfv9NnDIPQi0er86BcvAw5JjztSAv9JybBrXu3fB9lXLrpRZ7Z
 8Fc3HESxxqfGh2SlGLlf2IYthGqo6D8TNS4YzGmYcuDMKIMdLIEColIQZfqrl36qXxC4
 fqVQ==
X-Gm-Message-State: AOJu0YztuyMcWOf7USldym7UJLGrOlCPLgBbuBWbEXo1CK+l4QkiLNeb
 yuO7c+L4xbWNFKbiavk/2s8os/ZSg0LuBXc9ewhnkF0+DlvT9vWSGqJ6idIu4JRaL2cJ57Oer2w
 I8G78EXPrZenrzDa7TRIxt+59IjlbDBE90IA3weZhxKaQMdY2YR3SP495sXIjwibf
X-Gm-Gg: Acq92OGQ26x0T9VQkrg+zf55aysrcG/o11nJdi/g2J2mgpePIsa2joeI8GiNxJQusZn
 iZdaR6MKxlEFCmM1WDBKw7TjkvO9tOAugQeIW1GvhYtBpE7/VhUJQjlJepnoEP/pCLBffQGd2Yi
 iik+I2O9gGz10M+91DuNTMdv7LXAzNrK12BQbY0ZojiLWccth6uO9n74Kk3U/hLRyAnCFotKjS7
 3PKdVGOr/hzq1/fMK7zk87oOVhsA8rO839VBo8J4aZZSco2V5kkB5S4p8oiprJzR8rdNQRdUexy
 qrRDyYPKwfJGbN9LBMxX1qlJWy9BpV/cGSu+PSBDJwRHrabJ32TssdvXZJK1t/G06VXA+S1yDyv
 HO9DDaI91Wgdt1f+hLZCOHC7KogB1cT8JYS38164zybNHpCA=
X-Received: by 2002:ac8:6f16:0:b0:50d:9033:f2ec with SMTP id
 d75a77b69052e-5162f61c9e8mr64487641cf.50.1778704638706; 
 Wed, 13 May 2026 13:37:18 -0700 (PDT)
X-Received: by 2002:ac8:6f16:0:b0:50d:9033:f2ec with SMTP id
 d75a77b69052e-5162f61c9e8mr64487171cf.50.1778704638098; 
 Wed, 13 May 2026 13:37:18 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5148e82579fsm153984961cf.24.2026.05.13.13.37.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 13:37:17 -0700 (PDT)
Date: Wed, 13 May 2026 16:37:16 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v4 11/13] system/physmem: make ram_block_discard_range()
 handle guest_memfd
Message-ID: <agTg_IaGfrcWXw03@x1.local>
References: <20260504-rdm5-v4-0-bdf61e57c1e1@redhat.com>
 <20260504-rdm5-v4-11-bdf61e57c1e1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260504-rdm5-v4-11-bdf61e57c1e1@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, May 04, 2026 at 04:30:17PM +0400, Marc-André Lureau wrote:
> Most callers of ram_block_discard_range() want to discard both the
> shared and guest_memfd backing. Only kvm_convert_memory() intentionally
> discards a single plane during private/shared conversions.
> 
> Rename the current implementation to ram_block_discard_shared_range()
> and make ram_block_discard_range() a composite that also discards
> guest_memfd when present (rb->guest_memfd >= 0). This ensures callers
> like virtio-mem, virtio-balloon, hv-balloon, migration.. reclaim
> private pages on discard.
> 
> Update kvm_convert_memory() to use the plane-specific
> ram_block_discard_shared_range() since it only needs to discard
> the shared backing when converting to private.
> 
> Likewise, after TDVF image copy, use ram_block_discard_shared_range().
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


