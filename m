Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80361C28B20
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 16:28:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u00wm-0007jj-9R; Wed, 02 Apr 2025 12:28:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u00wk-0007jK-VH
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 12:28:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u00wi-0005t1-Uv
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 12:28:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743611286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SB9zXy6Vx2D4wO34LFzHetxtO1oIJgMdiBSQ+VGuCzs=;
 b=Gf8wyUHk1xdTtUiocniWo5jrXPRHoSvZ/1NKc4KZrPGhw7PUfw5lRwEuORtzQI9S/xGjPl
 +xifRrm1Zv1SN64yl/7ZYw3rnoHIyVDNlMZM0AaU2JLAfBCCjsEFMQ2J5JeNYPzDfBKRD7
 klz3J1VqAHUT/tQfrGksq7Zr+jHatn8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-Nh2zivWRPsSfo9eNvmn4Nw-1; Wed, 02 Apr 2025 12:28:05 -0400
X-MC-Unique: Nh2zivWRPsSfo9eNvmn4Nw-1
X-Mimecast-MFC-AGG-ID: Nh2zivWRPsSfo9eNvmn4Nw_1743611284
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43cf446681cso43254325e9.1
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 09:28:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743611283; x=1744216083;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SB9zXy6Vx2D4wO34LFzHetxtO1oIJgMdiBSQ+VGuCzs=;
 b=cboJ/CHSWYNyfqdkckbpd62aa6RsInclVCJLdcKVDpokTIyn3mLNYyR0CmhZ2ebqXS
 hS4jisjuEhxLR9NdjuzVwmorg0Hnv6QvswhfTFPJGS79Sp6l9POFNVFcjJY6xXzCzw7L
 XAvRodTPNI3Z9VCz9hlNbukZ2J+hzRxtoeKU5dGc9sq7ifAcGn9Mnv8Qhr6GKqLnkjop
 qGnY8ibrzAvP4Sbh0+s7tWlQaaNKyYNN2UzfXXdHrwmuDYacByhjBApvZVizhsyD9oSh
 4Mr4Hwk8IqeczMaYwyehbLXX5XMFeOOf4FZa5aqfQMblIFjgSLU+EvoWp6Ie0otRQ0uq
 PmCA==
X-Gm-Message-State: AOJu0Yy1jmzb76fIa6zASyISToSMnEcYf4QNEQIcRfLwmMWmYuqZKdJm
 86d0+tkJfHxbfpdSXe7XuTUBiPqnIUjR9tpxMnzzkwugCAflbupNTykeCdabLxiQJErxlFByGp5
 kmJqIQvXeCjTCzmtrwh6MyVxBy5VkRtpmh1u/fxT2uhKyqseYzTfI
X-Gm-Gg: ASbGncvY3zCrXpizZDGKSP+37U/ayL0mD8ixppH1oB9kiTF4+4AewzKb+b2pC7R+o4r
 uTk2Oj9GPQi78rixqaErkUCKR6WLoNrQln7s5TriYNmnLWNH5b9BPE67jf9O0tkKjPFP5F4wYiB
 GvAG4m5w4KgJl01x1N/OqZ2kaiTRe3RcCZg9reRW0S+kzpZku9i+vZRXitJiccQGYiJJiLetmQF
 MMfqOJhPy9u/K6Ql3aQ7sURu9AIHjug6rsMRn7B6cUr4U01abFgOYWG8i9CG4j6PNpviks8P+IH
 FwsPMjcZPg==
X-Received: by 2002:a05:6000:184e:b0:39c:12ce:1052 with SMTP id
 ffacd0b85a97d-39c12ce10fbmr14634924f8f.7.1743611283588; 
 Wed, 02 Apr 2025 09:28:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqDro/09BBTX4/dT0m+8UGXGlY89ttkpFcpAow6cGdxAMTYRmKdSk+x8JLW8YRlAl8qOHBxw==
X-Received: by 2002:a05:6000:184e:b0:39c:12ce:1052 with SMTP id
 ffacd0b85a97d-39c12ce10fbmr14634900f8f.7.1743611283192; 
 Wed, 02 Apr 2025 09:28:03 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b66a991sm17345908f8f.49.2025.04.02.09.28.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Apr 2025 09:28:02 -0700 (PDT)
Date: Wed, 2 Apr 2025 12:27:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] tests/functional: fix race in virtio balloon test
Message-ID: <20250402122751-mutt-send-email-mst@kernel.org>
References: <20250304183340.3749797-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250304183340.3749797-1-berrange@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Mar 04, 2025 at 06:33:40PM +0000, Daniel P. Berrangé wrote:
> There are two race conditions in the recently added virtio balloon
> test
> 
>  * The /dev/vda device node is not ready
>  * The virtio-balloon driver has not issued the first stats refresh
> 
> To fix the former, monitor dmesg for a line about 'vda'.
> 
> To fix the latter, retry the stats query until seeing fresh data.
> 
> Adding 'quiet' to the kernel command line reduces serial output
> which otherwise slows boot, making it less likely to hit the former
> race too.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

ok

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  tests/functional/test_virtio_balloon.py | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/functional/test_virtio_balloon.py b/tests/functional/test_virtio_balloon.py
> index 67b48e1b4e..308d197eb3 100755
> --- a/tests/functional/test_virtio_balloon.py
> +++ b/tests/functional/test_virtio_balloon.py
> @@ -32,7 +32,7 @@ class VirtioBalloonx86(QemuSystemTest):
>          'e3c1b309d9203604922d6e255c2c5d098a309c2d46215d8fc026954f3c5c27a0')
>  
>      DEFAULT_KERNEL_PARAMS = ('root=/dev/vda1 console=ttyS0 net.ifnames=0 '
> -                             'rd.rescue')
> +                             'rd.rescue quiet')
>  
>      def wait_for_console_pattern(self, success_message, vm=None):
>          wait_for_console_pattern(
> @@ -47,6 +47,9 @@ def mount_root(self):
>          prompt = '# '
>          self.wait_for_console_pattern(prompt)
>  
> +        # Synchronize on virtio-block driver creating the root device
> +        exec_command_and_wait_for_pattern(self, "while ! (dmesg -c | grep vda:) ; do sleep 1 ; done", "vda1")
> +
>          exec_command_and_wait_for_pattern(self, 'mount /dev/vda1 /sysroot',
>                                            prompt)
>          exec_command_and_wait_for_pattern(self, 'chroot /sysroot',
> @@ -65,10 +68,21 @@ def assert_initial_stats(self):
>              assert val == UNSET_STATS_VALUE
>  
>      def assert_running_stats(self, then):
> -        ret = self.vm.qmp('qom-get',
> -                          {'path': '/machine/peripheral/balloon',
> -                           'property': 'guest-stats'})['return']
> -        when = ret.get('last-update')
> +        # We told the QEMU to refresh stats every 100ms, but
> +        # there can be a delay between virtio-ballon driver
> +        # being modprobed and seeing the first stats refresh
> +        # Retry a few times for robustness under heavy load
> +        retries = 10
> +        when = 0
> +        while when == 0 and retries:
> +            ret = self.vm.qmp('qom-get',
> +                              {'path': '/machine/peripheral/balloon',
> +                               'property': 'guest-stats'})['return']
> +            when = ret.get('last-update')
> +            if when == 0:
> +                retries = retries - 1
> +                time.sleep(0.5)
> +
>          now = time.time()
>  
>          assert when > then and when < now
> -- 
> 2.48.1


