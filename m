Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D854C3ABC3
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 15:33:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDPin-0002Mi-36; Fri, 09 May 2025 11:33:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uDPil-0002Hv-J8
 for qemu-devel@nongnu.org; Fri, 09 May 2025 11:33:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uDPih-0000bk-Oo
 for qemu-devel@nongnu.org; Fri, 09 May 2025 11:33:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746804781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HF1cS9gfAo2rcZXKkey3ykdutt66dRszJyEJ5ClUACs=;
 b=Jdq9a8HG8ubWIg9muWZ62Q1JGqj8kIEfsekrXHvZQGbogZdIUgxtohzDhnscE9e2tgfZ6d
 zsjEW+AYLkwB9smqDtu1wbcdvUVBZgQ4xewZE5DM/qf7X2ydG5nfzOMapmWXdpUS9Ef73v
 brX6GsKM59t12ctwkEHiqdrPsljA+HI=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-uoPrwnF3Ma-Kfb1D8xtH-A-1; Fri, 09 May 2025 11:32:59 -0400
X-MC-Unique: uoPrwnF3Ma-Kfb1D8xtH-A-1
X-Mimecast-MFC-AGG-ID: uoPrwnF3Ma-Kfb1D8xtH-A_1746804779
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6f6e7bc2598so10787046d6.0
 for <qemu-devel@nongnu.org>; Fri, 09 May 2025 08:32:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746804779; x=1747409579;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HF1cS9gfAo2rcZXKkey3ykdutt66dRszJyEJ5ClUACs=;
 b=snXs9IFngSbC0Sn+o1qj1h+xEXZOrDLXq4xIU7gpmRHxJA4zI3ZXetit6XY/KvLpFS
 pJQU09UZec7Y6ODtwVL/yGgzmwaQQxwxjjhACXaGr1sc1FeCZmKPZc1htHaBTRShvKAb
 UmaP8MSiLkKw0XkYW6OxmC64OVcNjHBhcEhQoQvJ84MTHeNZczxL/0tw8n8HoBcoZZy1
 zNjVkZYe7h4bXV6DhbZb9GK8YhTgXPHjCOzYt0PS6YTl3pqtmdAvuwT/FFHOaWL/WWbq
 W7R4MU0q+G79Q3sljJQBoyhRzOlLoQOSpV9nj+bss1DMSPZGBxcFGpPuaxW1HWYp6fPI
 EDfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEHqZLBOOJlCN2CpwNSVyGPFdT7GrmpG5smOWqb/Mm3inzi0nDIrsQRRpXV8IjzIYo9bvvVGNHQ3C2@nongnu.org
X-Gm-Message-State: AOJu0YzXYGls6bFAHOnR6O7+f3wqx3iLJ5AztmTlOedSwbsPZbLWs4Be
 24fAJuhHuCuRup849Nxs78zvdxyqFoC52SZzhn2kFPHSjcfN7YjKl5/NdVA3FayLphej3aV/AXO
 fIDQuaZrxP+nHaFoyzDIdVeTiKu/KXMUEDoideEjW/fRa8sGnlNSQ
X-Gm-Gg: ASbGnctrwAwsMBF521O4jvZwpebzh6lQh2onyBBJvxsMfI+bzr2+wEYfw68x9Us2pgI
 0alClUxMBAe0xykjl/NLYxE6mRI9jTFIdjkqMD9IRAOzjkH4rZoyZREg3Ua6W2JaEvM8HGf4Q1m
 is2hyionJi2hojp+/6s98YMkbNH/h1nos29bT3/+NHwn76NR60aowzHCEka980EVwfxUtYMgo12
 H+F3xr2QmwKQpq3MMY3x5mMCM34fZqlstEXzH6x39Tq16mBdOjGuhm+HtmxFYlKCf/QijRYsshv
 jLs=
X-Received: by 2002:ad4:5ae1:0:b0:6f4:b265:261 with SMTP id
 6a1803df08f44-6f6e479775bmr71227156d6.8.1746804779173; 
 Fri, 09 May 2025 08:32:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYKWr4tQbYu7n3zcaQzSu/hFbxuaVP23zYKR8aOctm9+cle8UpU/AiqlpFG+cfNk0IsdwyvA==
X-Received: by 2002:ad4:5ae1:0:b0:6f4:b265:261 with SMTP id
 6a1803df08f44-6f6e479775bmr71226726d6.8.1746804778832; 
 Fri, 09 May 2025 08:32:58 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6f6e3a471c7sm14920026d6.90.2025.05.09.08.32.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 May 2025 08:32:58 -0700 (PDT)
Date: Fri, 9 May 2025 11:32:54 -0400
From: Peter Xu <peterx@redhat.com>
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Jack Wang <jinpu.wang@ionos.com>,
 "Michael R . Galaxy" <mrgalaxy@nvidia.com>, Yu Zhang <yu.zhang@ionos.com>
Subject: Re: [PATCH v2 2/2] qtest/migration/rdma: Add test for rdma migration
 with ipv6
Message-ID: <aB4gJh8drTWmcQfy@x1.local>
References: <20250509014211.1272640-1-lizhijian@fujitsu.com>
 <20250509014211.1272640-2-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250509014211.1272640-2-lizhijian@fujitsu.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.413,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 LOTS_OF_MONEY=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, May 09, 2025 at 09:42:11AM +0800, Li Zhijian wrote:
> Recently, we removed ipv6 restriction[0] from RDMA migration, add a
> test for it.
> 
> [0] https://lore.kernel.org/qemu-devel/20250326095224.9918-1-jinpu.wang@ionos.com/
> 
> Cc: Jack Wang <jinpu.wang@ionos.com>
> Cc: Michael R. Galaxy <mrgalaxy@nvidia.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Yu Zhang <yu.zhang@ionos.com>
> Reviewed-by: Jack Wang <jinpu.wang@ionos.com>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
> 
> V2:
>   - Collect Reviewed-by
>   - quoate the whole string to adapt to the newer bash # Fedora40+
> ---
>  scripts/rdma-migration-helper.sh      | 26 +++++++++++++++++++++++---
>  tests/qtest/migration/precopy-tests.c | 21 +++++++++++++++++----
>  2 files changed, 40 insertions(+), 7 deletions(-)
> 
> diff --git a/scripts/rdma-migration-helper.sh b/scripts/rdma-migration-helper.sh
> index a39f2fb0e5..9fb7a12274 100755
> --- a/scripts/rdma-migration-helper.sh
> +++ b/scripts/rdma-migration-helper.sh
> @@ -8,6 +8,15 @@ get_ipv4_addr()
>          head -1 | tr -d '\n'
>  }
>  
> +get_ipv6_addr() {
> +    ipv6=$(ip -6 -o addr show dev "$1" |
> +        sed -n 's/.*[[:blank:]]inet6[[:blank:]]*\([^[:blank:]/]*\).*/\1/p' |
> +        head -1 | tr -d '\n')
> +
> +    [ $? -eq 0 ] || return
> +    echo -n "[$ipv6%$1]"
> +}
> +
>  # existing rdma interfaces
>  rdma_interfaces()
>  {
> @@ -20,11 +29,16 @@ ipv4_interfaces()
>      ip -o addr show | awk '/inet / {print $2}' | grep -v -w lo
>  }
>  
> +ipv6_interfaces()
> +{
> +    ip -o addr show | awk '/inet6 / {print $2}' | sort -u | grep -v -w lo
> +}
> +
>  rdma_rxe_detect()
>  {
>      for r in $(rdma_interfaces)
>      do
> -        ipv4_interfaces | grep -qw $r && get_ipv4_addr $r && return
> +        "$IP_FAMILY"_interfaces | grep -qw $r && get_"$IP_FAMILY"_addr $r && return
>      done
>  
>      return 1
> @@ -32,11 +46,11 @@ rdma_rxe_detect()
>  
>  rdma_rxe_setup()
>  {
> -    for i in $(ipv4_interfaces)
> +    for i in $("$IP_FAMILY"_interfaces)
>      do
>          rdma_interfaces | grep -qw $i && continue
>          rdma link add "${i}_rxe" type rxe netdev "$i" && {
> -            echo "Setup new rdma/rxe ${i}_rxe for $i with $(get_ipv4_addr $i)"
> +            echo "Setup new rdma/rxe ${i}_rxe for $i with $(get_"$IP_FAMILY"_addr $i)"
>              return
>          }
>      done
> @@ -50,6 +64,12 @@ rdma_rxe_clean()
>      modprobe -r rdma_rxe
>  }
>  
> +IP_FAMILY=${IP_FAMILY:-ipv4}

Does this mean I'll need to setup twice, one for each v?

Even if so, I did this:

===8<===
$ sudo ../scripts/rdma-migration-helper.sh setup
Setup new rdma/rxe wlp0s20f3_rxe for wlp0s20f3 with 192.168.68.123
$ sudo IP_FAMILY=ipv6 ../scripts/rdma-migration-helper.sh setup
Setup new rdma/rxe tun0_rxe for tun0 with [fd10:22:88:1::110c%tun0]
$ rdma link
link wlp0s20f3_rxe/1 state ACTIVE physical_state LINK_UP netdev wlp0s20f3
link tun0_rxe/1 state ACTIVE physical_state LINK_UP netdev tun0
===8<===

And it still fails..

===8<===
$ sudo QTEST_QEMU_BINARY=./qemu-system-x86_64 ./tests/qtest/migration-test -p /x86_64/migration/precopy/rdma/plain
TAP version 14
# random seed: R02S778a51bb3555664ae9449bf4fb9e3730
# starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-286985.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-286985.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -machine none -accel qtest
# Start of x86_64 tests
# Start of migration tests
# Start of precopy tests
# Start of rdma tests
# Running /x86_64/migration/precopy/rdma/plain
# Using machine type: pc-q35-10.1
# starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-286985.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-286985.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -accel kvm -accel tcg -machine pc-q35-10.1, -name source,debug-threads=on -m 150M  -serial file:/tmp/migration-test-QEB452/src_serial -drive if=none,id=d0,file=/tmp/migration-test-QEB452/bootsect,format=raw -device ide-hd,drive=d0,secs=1,cyls=1,heads=1    -accel qtest
# starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-286985.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-286985.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -accel kvm -accel tcg -machine pc-q35-10.1, -name target,debug-threads=on -m 150M  -serial file:/tmp/migration-test-QEB452/dest_serial -incoming rdma:192.168.68.123:29200  -drive if=none,id=d0,file=/tmp/migration-test-QEB452/bootsect,format=raw -device ide-hd,drive=d0,secs=1,cyls=1,heads=1    -accel qtest
ok 1 /x86_64/migration/precopy/rdma/plain
# slow test /x86_64/migration/precopy/rdma/plain executed in 1.46 secs
# Start of plain tests
# Running /x86_64/migration/precopy/rdma/plain/ipv6
# Using machine type: pc-q35-10.1
# starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-286985.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-286985.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -accel kvm -accel tcg -machine pc-q35-10.1, -name source,debug-threads=on -m 150M  -serial file:/tmp/migration-test-QEB452/src_serial -drive if=none,id=d0,file=/tmp/migration-test-QEB452/bootsect,format=raw -device ide-hd,drive=d0,secs=1,cyls=1,heads=1    -accel qtest
# starting QEMU: exec ./qemu-system-x86_64 -qtest unix:/tmp/qtest-286985.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-286985.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -accel kvm -accel tcg -machine pc-q35-10.1, -name target,debug-threads=on -m 150M  -serial file:/tmp/migration-test-QEB452/dest_serial -incoming rdma:[fdd3:4fdc:97c9:ca4e:2837:28dd:1ec4:6b5a%wlp0s20f3]:29200  -drive if=none,id=d0,file=/tmp/migration-test-QEB452/bootsect,format=raw -device ide-hd,drive=d0,secs=1,cyls=1,heads=1    -accel qtest
qemu-system-x86_64: -incoming rdma:[fdd3:4fdc:97c9:ca4e:2837:28dd:1ec4:6b5a%wlp0s20f3]:29200: RDMA ERROR: could not rdma_getaddrinfo address fdd3:4fdc:97c9:ca4e:2837:28dd:1ec4:6b5a%wlp0s20f3
Broken pipe
../tests/qtest/libqtest.c:199: kill_qemu() tried to terminate QEMU process but encountered exit status 1 (expected 0)
Aborted
===8<===

It would be great if the setup only needs to be run once, setting up
whatever ipv* supported, then in the test run kickoff whatever ipv* is
supported and detected.

Would it be possible?

Thanks,

-- 
Peter Xu


