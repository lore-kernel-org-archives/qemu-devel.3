Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49158CF34C3
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 15:23:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLk12-0002AG-RP; Wed, 19 Nov 2025 10:22:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vLk11-00029x-33
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 10:22:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vLk0z-0004xj-71
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 10:22:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763565755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qBl29ZSMogptSJkquQKffi8XsroHWWjT0MAjfrnqe5o=;
 b=f9eqcqDqnwmw3wWcrgv//vgnTrDCwo9G4nJ18hqFJ6IhdctiM5GI3UFCYRA9upJSDc2eqC
 yRhl0+hPPIn1tlPQA1HmLgFuEbkvox9np3+uerhdeS5ohJI11RhZXeBKXFDNatzX6DuHMP
 8O6UPga4CtiY5lCTrwGxixRTImbjFRI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-SP9h4sdHPiizKpkO1pyOpQ-1; Wed, 19 Nov 2025 10:22:32 -0500
X-MC-Unique: SP9h4sdHPiizKpkO1pyOpQ-1
X-Mimecast-MFC-AGG-ID: SP9h4sdHPiizKpkO1pyOpQ_1763565751
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-42b2fb13b79so3346672f8f.3
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 07:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763565751; x=1764170551; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qBl29ZSMogptSJkquQKffi8XsroHWWjT0MAjfrnqe5o=;
 b=MCjy4KX9GevqRuCDN7DS0uEKypNX5vusDP+Qj45wKX4Qydiiurqv8Q0blbuwChb8k4
 rSLsP7IsI+f+ioBbkDQR2xHvlt5iJepWAYJF7pyKXzqpTzqVO5Y3vaNJ47eDWnBDXuyP
 5rL+tswbwNdcXxtwQvHaAUdJGxFm5/J8YlGKvy7ql1flxe76yQgmP8oMehtK0PBeH2wy
 MIOZ/Fip7VMPFL8Zno6KaVClKFmNFr8C5i0ji6iWPzoDa3l6EDGMnY6NJibawBe0goQL
 K6iic0zCEucJHNNoi2EuTwmMDJEv2hwj4LG913kFFtjB3ztkHx4aqV2xGHznRI2ixWv3
 QTcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763565751; x=1764170551;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qBl29ZSMogptSJkquQKffi8XsroHWWjT0MAjfrnqe5o=;
 b=uwg0ol4+9VvhmQMCswjW0v1hNhv4oILIN/TjUdJ4oKoE5NQxjkKXHe33n5rMa1m9HA
 sBWvoaidNj99/Radh8tRysYgoRFXbLs46yeUEFirMl8+OMVat/BFAyUA1mDPyCDBZJhH
 4OYhMsdyeNwjolSwV/bV1FWztLaxLl9w4wb5Sqapnu57qjFcrWr8LW+5IvtkF1OR4n2n
 exLanFY13X7mF7iukKPoY9TZ5k2cGsxiAKR3xMDlxSf+zr8qxeJX2M2a8/4MPbSzgw+u
 zYI66WkoXgVg+hH/S+ftsZir8S5wh47X2llef8fMPeVLneBL7PGgVi0oewBk9GvddWfe
 bbZQ==
X-Gm-Message-State: AOJu0YxHoIOh1FCXKhb5zIf8jQan/VnRfARfw22FPAAmlojc0IjT3nAw
 TCYGAKLGL9PnKHljYmhi25fiGDvbK3aA1+pAjFRr+11rtyN3QKiL3bkVqb5Zu2e7N9C189jcx28
 XeyDT/L+enz1zMdAX2eaxgiP5N5TEzAt32RtXaFZS3o01PXNTsELai7xE
X-Gm-Gg: ASbGncvHNnG8RXoWxFOAeAzzEtTc1P0I8XG+T9ialxNqG1o98Gxr3mqog/1ebDt6Unj
 lhEUaWdZS1rtlRKlQyWOLd6P0yV93kT6XKBBcEoE8rNsDzjiE/ssiihcjW3+kTRYW/Zq0ZsWoxw
 lh6NrVsAqUxHETFiQ4qiKQ1fXGxjPi7OnM16C/P6JIMLOhrGPmTsAJjvglB8xooBVtmwc+HnjLm
 58ikOFu72gkL+1upRMsBhmVi1AlrmBviJwG1y/q5BLxtGyg2JFpCzYKNkA5a2iugupSXl8hmcV+
 yfb4+ZqWJ7KfleVw7a4iuC9BepxSMcOGJdC3cp0yPbmamWc0WkjeYJXvjpfzF0eFmOXekR1o5R6
 cn2N6Y4y8Hr2KFdzTEjn6ZmGgCuKiLBPT6qBPbGSOPrnTV1aQJxXSesdHjLzYIEaL4uP4UcA3Cc
 gGxGwsdlXyDZuNYQUvGUI8217cZoI2DUWk7iVzjqg=
X-Received: by 2002:a5d:584e:0:b0:42b:4081:ccea with SMTP id
 ffacd0b85a97d-42b593679dbmr20490373f8f.35.1763565751291; 
 Wed, 19 Nov 2025 07:22:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmlnxwXPWhfCDA34fPchWO0rfMki5LoTn/w01ZOSk8sudRu9HyiOR6EzEwXkCEgNg4WPUEzw==
X-Received: by 2002:a5d:584e:0:b0:42b:4081:ccea with SMTP id
 ffacd0b85a97d-42b593679dbmr20490347f8f.35.1763565750894; 
 Wed, 19 Nov 2025 07:22:30 -0800 (PST)
Received: from ?IPV6:2003:cf:d717:1f1a:9fb6:2cca:37fd:c35c?
 (p200300cfd7171f1a9fb62cca37fdc35c.dip0.t-ipconnect.de.
 [2003:cf:d717:1f1a:9fb6:2cca:37fd:c35c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e84a4fsm38509109f8f.11.2025.11.19.07.22.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Nov 2025 07:22:29 -0800 (PST)
Message-ID: <f08a0a6e-e379-4e25-bee9-554bd48dd344@redhat.com>
Date: Wed, 19 Nov 2025 16:22:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] qcow2: Add keep_data_file command-line option
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
References: <20250530084448.192369-1-hreitz@redhat.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20250530084448.192369-1-hreitz@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Ping

On 30.05.25 10:44, Hanna Czenczek wrote:
> Hi,
>
> This series adds a keep_data_file qemu-img create option to qcow2 that
> makes it keep the given external data file for a newly created image
> instead of overwriting it.
>
> This allows to create a qcow2 image for an existing raw image using the
> qemu-img create command, which previously wasn’t easily possible
> (besides work-arounds using a temporary data file or qemu-img amend).
>
> (The “proper” way of doing it without this option is to use QMP
> blockdev-create.)
>
> This new option is a pure qemu-img create (i.e. command-line) option,
> not available via QMP, because it does not make any sense there.  See
> patch 1 for more explanation.
>
> (See https://issues.redhat.com/browse/RHEL-73509 for perhaps a bit more
> context.)
>
>
> Hanna Czenczek (4):
>    qcow2: Add keep_data_file command-line option
>    qcow2: Simplify size round-up in co_create_opts
>    iotests/common.filter: Sort keep_data_file
>    iotests/244: Add test cases for keep_data_file
>
>   include/block/block_int-common.h |  1 +
>   block/qcow2.c                    | 78 +++++++++++++++++++++++++++++---
>   tests/qemu-iotests/082.out       | 18 ++++++++
>   tests/qemu-iotests/244           | 71 +++++++++++++++++++++++++++++
>   tests/qemu-iotests/244.out       | 53 ++++++++++++++++++++++
>   tests/qemu-iotests/common.filter |  2 +-
>   6 files changed, 216 insertions(+), 7 deletions(-)
>


