Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D13CA6007
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 09:46:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEkhl-0005aZ-28; Thu, 08 Oct 2026 05:46:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xEkhj-0005Wv-1x
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 05:46:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xEkhg-0005MV-Oc
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 05:46:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791452779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qn/tNzDzBAcCcCNo7Wkm3hdA90voiHaANqnZhtP7wvg=;
 b=EX0XnGQIhZM2Cuq2OHI2eKrKoa0Ycqz5icfNWHUWvXnaqEpbGnhmEhzHIyOoSPizP5aBZO
 gtl1C1GD7oB5zUu07ROsQDjimVxNTkhlM9YJRnzprDXC/FMaywaR6DJkFRqq9Su5k/jg6c
 6vdXq11+4F3SfQEB03ylzc19u/2qX0U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-AKHWYkPSNc2kfTvOS8BWxA-1; Thu, 08 Oct 2026 05:46:14 -0400
X-MC-Unique: AKHWYkPSNc2kfTvOS8BWxA-1
X-Mimecast-MFC-AGG-ID: AKHWYkPSNc2kfTvOS8BWxA_1791452773
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-48c427421f6so3324991f8f.2
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 02:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791452773; x=1792057573; darn=nongnu.org;
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:message-id:subject:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qn/tNzDzBAcCcCNo7Wkm3hdA90voiHaANqnZhtP7wvg=;
 b=l8xDtl3XsgM2DV5RkzuglKqAs1nHD/gDTlxVmAbNOujCvn5sMxmVJmQigh3cIlCg4j
 bVpUcReANF3KdeqUGO/2x2OyUuMmaI55GtHCm2nO7u9HsbfJarntCV2oNNEBPgKLXWeb
 78N92J+oxAvKE4lJ9XjCTuS1G7J5y7Yq7cvEUN8q4skWsqt/Q69wHKxLM+C9Tzk+0QqV
 Lc/19moKRSe/nel6mkpShuoC7TSAGdrI1hcY/COg4ASmIPRMaFgYkv6yZ4/WJENtK1hP
 heurUab21EEJl/yQvo32vLLchAcqEXgIDrqYbF9e0Ac2dGFfe67cr6QSJLQW8Uh3rjXK
 g/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791452773; x=1792057573;
 h=content-transfer-encoding:content-disposition:content-type
 :mime-version:message-id:subject:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qn/tNzDzBAcCcCNo7Wkm3hdA90voiHaANqnZhtP7wvg=;
 b=tDh7hkSu3KEDo8WYMBYr6DcB02DhHPJuBQungMPjzcF32xxF0K6hdWp68REZdK8Krz
 SnDzlBw2ytGG73P7srWi5G06F9Q4Ux4qhWfvCqRaH9jOGZFuuz2hBvMT7eT0vEzabcW4
 ud10CmUzsj6YjiLRRwKdQ1kUUzK1CnSadfL+r1XlNJNFpptppfbBPbIwLqf+MYeFsPFg
 OuEzLNI8JYI5eeVC0qukn378Y1SFAy8JwolweOWTJJ/9LMsT1Q0jrtRytMknAM/8KbGu
 ONv7+2IHJiTc1cie5Yi5tYy3BijvOVrKCRDFr8osHx04c4LGL2VnuDQraVGBdykS8cNh
 6mZw==
X-Gm-Message-State: AFq9FYI2sT2MCUabciLZVyegVuK3PQbNFP16Y9GWMwkRRuUN6Bf9uguA
 fdFUeET61JDUgBxG8ukVJ6dC7jRBmepIEsDyW8Pve3OR4lzTat7pK11Z5eOyHRh5sKK2t9rx6Wv
 7OgkU0AEIrjaWuR1ckH1DjY7qGKohYnz3uTqaEe0ZE7wyXUbW8gfPWjlajzFjxHUcTa6lvoCpo/
 PV83LUPdlj8PwWi5iH4QsClbq8T4hc1lHKOw==
X-Gm-Gg: AYBFou15GFA/a3nYS8lgYxmOqfCNDVqWR4RD199ksbHvQptmccyNei4qhFFMh0OG324
 WVM+G1FkZ8AY9doFdgCpzGilziB9x6Kl9TKL8DDoJkqoCdKnwaNfbS+6kn13wDL1H58qSAc5MR3
 PhzXy2OFlPAxleMmnikGaC1+xWFbxzRwfyrFYb1XME7wRYlDuGAmQlH7dyBqn2Y3rH8fwIWxf+L
 CqkI63HNJfi78hriKJIuFBN0S7BVXpwdqwtUcXiTcaQlTn5EqdfX1fDi1h2n6nIbfVBiKEsJ89v
 178FOu/Nm1ZX+8abTytMZiMTYgswFcMVtoRD16euFFqaxpbVREvWULzjjb8B7aJ9WtUzhqw=
X-Received: by 2002:a05:6000:4a0a:b0:48a:f61d:1b03 with SMTP id
 ffacd0b85a97d-48c728a2184mr9058375f8f.47.1791452772824; 
 Thu, 08 Oct 2026 02:46:12 -0700 (PDT)
X-Received: by 2002:a05:6000:4a0a:b0:48a:f61d:1b03 with SMTP id
 ffacd0b85a97d-48c728a2184mr9058313f8f.47.1791452771986; 
 Thu, 08 Oct 2026 02:46:11 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c71d3032csm9716945f8f.45.2026.10.08.02.46.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 02:46:10 -0700 (PDT)
Date: Thu, 8 Oct 2026 05:46:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [Re: Create vhost-user@lists.linux.dev]
Message-ID: <20261008054300-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi guys,
at LPC we agreed to be more inviting to non-qemu implementations of the
vhost-user protocol, as a 1st step, by making a mailing list for vhost
user spec patches. This way people can follow just these patches if they
want.

I started the process, will take a bit, see below (redacted):

----- Forwarded message -----

Date: Thu, 8 Oct 2026 16:05:41 +0800
To: "Michael S. Tsirkin" <mtsirkin@redhat.com>
Subject: Re: Create vhost-user@lists.linux.dev

Hi Michael,

We can do this - however there will be a delay, as it will have to be
after we finish implementing new list server infrastructure (which is
happening at the moment). I don't have an ETA currently for when we
will be adding new lists - likely weeks, not months - at this point.

apologies for any inconvenience.

cheers

...

On Thu, Oct 8, 2026 at 3:21 PM Michael S. Tsirkin <mtsirkin@redhat.com> wrote:
>
> Address    : vhost-user@lists.linux.dev
> Description: vhost-user protocol spec and related tools/libraries
> Owners     : mst@kernel.org,  sgarzare@redhat.com, stefanha@redhat.com
> Allow HTML : y
> Archives   : Y
>
> Reasons for the list and additional info:
> We need a separate list for vhost-user protocol spec and tools working
> with the protocol.
>
>

----- End forwarded message -----


