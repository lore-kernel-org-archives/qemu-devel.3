Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98B9DCF8860
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 14:04:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM5GM-00020o-Ss; Thu, 20 Nov 2025 09:03:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vM5GL-00020V-0e
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 09:03:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vM5GJ-0000c3-1I
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 09:03:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763647429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XVBd8e6c1f6wozihlK1UdgL6512rr1IeABVyWtTZ8rI=;
 b=blkcwT9e7BSdPvGx6uliEjDgN/0jUFYMmRPvo4I8enHkVF7EH59FQO0iSeOU8FnGABnOuH
 Zdz+9LeRnhEE5Wh0zR5cJj19QQmjnvixf1y7vwbKH2WEIulIlgtx5FBYHWnGanGbIX0vfK
 Mp2FHVbfE6lXSVIugtEQPwy8ZA2OFwM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-A7e43pJtO4em-ThXIsaJOw-1; Thu, 20 Nov 2025 09:03:47 -0500
X-MC-Unique: A7e43pJtO4em-ThXIsaJOw-1
X-Mimecast-MFC-AGG-ID: A7e43pJtO4em-ThXIsaJOw_1763647425
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-429c5f1e9faso950566f8f.3
 for <qemu-devel@nongnu.org>; Thu, 20 Nov 2025 06:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763647425; x=1764252225; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XVBd8e6c1f6wozihlK1UdgL6512rr1IeABVyWtTZ8rI=;
 b=uHmURoI+GFNTc0Q1v8SrJ6eDID8yaH8ZbYfvddooL+U820Hvd+W8JEB6g9Y65aoZXz
 M0MWSqxdS5C+bsgpVPSETG3RlUwnudAIlaNz0+ue9B1rRNTJoorl7L2llLPdfBqREdzt
 2pP1wcendZcQOOzN7SCXo/Jh7aGI5WiDFydRdS6hOjrv+Cw0D9RdRBqjPA3OKXcHY3WA
 f4bxbovzdVHRkIbjj4holp0b5mnlkMaE3ewzTbNHajKa0EHeNW+xjUrqXNs/xcQAxXNb
 J+HAx08/7I3JwOyNnjcDomo3mqJodjVif2fCfNlX8nAVxRZRFWZ1h7HJkP/Oy5+xCKBU
 w06A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763647425; x=1764252225;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XVBd8e6c1f6wozihlK1UdgL6512rr1IeABVyWtTZ8rI=;
 b=G/cUe8IL8W3HNyl6Q4+iY4yYmp1Lfozee1ZiPihqtqElIrNVrI9asnolvmywYomvjS
 KwJBaZw4bUdy5XZwxSzpZcFxPBJiVGjSNo+JvnOZqXXkO87TX4CC1CTvw+GTDFBcBVkU
 dy1vwhg1fmCZmQDtmB/AtZH+bBe30oYL6qzzwdZsxT2rXA6mQUlk6UA5yosoZgO6uQxV
 DHPG1aOJVAH9AOX7q0uPCuas5sP7mHzictqFrl9i+ZR0tXVLCUrs7/4l6JG5v/DPsOTq
 hMPWY9Ncg4faNKcwSxZnHefexJhJByqoPq1SdJmGb3jpv0XliqwaWhFazPydHq5vyxTw
 wuJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrKUFGxHfysTB51GFwb1+OWcJW2Kac2UUzHCUBZK8EHO/9Ys5Lqdwb2ZBbyDqW6PYHXQuT6l2W4eLv@nongnu.org
X-Gm-Message-State: AOJu0YzpQ87N8Ms+pEAWYygkQOPF/eGhFvBWzjoOWwLP4WoOKfyQrkra
 DFq6+QmweFeYABkuLXeXXVByhC1d6GwPatdIWPFeDisptOgRfnNm2hI7/StT/tEa4keEdbSmo+b
 ypiMsaSIh/azwbyAQNdCyK7kd3MbwF120PcptZbjVxyg5eeH/0gMGvdOY
X-Gm-Gg: ASbGncvi9YMLvm/yjzAAGxpnYBsDOSzpHMGCrY2RJqnMiJgbgHAwcKkDuizSiZqww8g
 K8qxy4QcjqlArJQGRZjeCqLByzm4PLir4R3QJUiQjLa7UUDOS9itNFvX+W5uTefOvZFWyp/Ob4c
 vvALDRHCYjaCAgpMmGaaPVZ9K96Juu+ziXQL9cPCsagi6v1gRtJpDI6AT5qaL/+2qM0qL9ok3OF
 4bQTZd7s/sZ90ZRRh/XFezy29XogoUDtMCPUIo0yGsrpMGlVmVpWZpyAKFWelTbvvPlqWLxBjAp
 KDXUgbTdNNtNr4N7UonijkyVfu72rjgeRnj9XV93lYB8imbICV8kpedQ6p/SXHA6ThPibgRZ3Wk
 01yk1lIOF4E2KSdYrJsnkoQQLGo5FnIluuvh2EAYmnX+WJFuzhwUTc49Z4pVlACo4cj6NzXs5VK
 TchwGtqPhtNSF+YF77e413WpDjiiO2JBHMJu8ubmE=
X-Received: by 2002:a5d:5f91:0:b0:3ff:17ac:a34b with SMTP id
 ffacd0b85a97d-42cb9a5fc8cmr2612293f8f.42.1763647424647; 
 Thu, 20 Nov 2025 06:03:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFDI9z8K+iMP2muzgE9JrqTIjC9uBPNSe440bXy+ZxuqafQ0TTNUy4PCqjJ/wkjLWMcaLvtpQ==
X-Received: by 2002:a5d:5f91:0:b0:3ff:17ac:a34b with SMTP id
 ffacd0b85a97d-42cb9a5fc8cmr2612243f8f.42.1763647424022; 
 Thu, 20 Nov 2025 06:03:44 -0800 (PST)
Received: from ?IPV6:2003:cf:d717:1f20:85cf:d355:b628:643c?
 (p200300cfd7171f2085cfd355b628643c.dip0.t-ipconnect.de.
 [2003:cf:d717:1f20:85cf:d355:b628:643c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fa3a6bsm5599862f8f.28.2025.11.20.06.03.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Nov 2025 06:03:43 -0800 (PST)
Message-ID: <f5102d83-b67a-4ae1-b561-00b0d2563eb6@redhat.com>
Date: Thu, 20 Nov 2025 15:03:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block-backend: Fix race when resuming queued requests
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: andrey.drobyshev@virtuozzo.com, den@virtuozzo.com, f.ebner@proxmox.com,
 qemu-stable@nongnu.org, qemu-devel@nongnu.org
References: <20251119172720.135424-1-kwolf@redhat.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20251119172720.135424-1-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 19.11.25 18:27, Kevin Wolf wrote:
> When new requests arrive at a BlockBackend that is currently drained,
> these requests are queued until the drain section ends.
>
> There is a race window between blk_root_drained_end() waking up a queued
> request in an iothread from the main thread and blk_wait_while_drained()
> actually being woken up in the iothread and calling blk_in_flight(). If
> the BlockBackend is drained again during this window, drain won't wait
> for this request and it will sneak in when the BlockBackend is already
> supposed to be quiesced. This causes assertion failures in
> bdrv_drain_all_begin() and can have other unintended consequences.
>
> Fix this by increasing the in_flight counter immediately when scheduling
> the request to be resumed so that the next drain will wait for it to
> complete.
>
> Cc: qemu-stable@nongnu.org
> Reported-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   block/block-backend.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>


