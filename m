Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF4C6C47DD9
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Feb 2024 21:03:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reLe0-0000US-T3; Sun, 25 Feb 2024 16:02:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <g1pi@libero.it>) id 1reJAH-0005QX-8m
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 13:23:54 -0500
Received: from smtp-31-wd.italiaonline.it ([213.209.13.31] helo=libero.it)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <g1pi@libero.it>) id 1reJAD-0006EN-HJ
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 13:23:52 -0500
Received: from localhost ([151.29.140.90]) by smtp-31.iol.local with ESMTPA
 id eJA7rSi5Qj2oceJA8r59Ji; Sun, 25 Feb 2024 19:23:44 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
 t=1708885424; bh=kEHOZUFx16cfj7YE4Nv0UpBUYdnUSjT7/NpAfjx163c=;
 h=From;
 b=ngVwSYp6ztt0PKQXQPDW6ndAagLYDB1g5CITipc8aih8cCwU72ceV2+NB/XMdDpFW
 aPWBjdESUtqrL9HQOcfTlt7BDjCAetFHrrb/9qXe1e4NmJatBFjjjAYWF+DoFzVeOf
 6+l/+PDOO7Z1uBXtfVfHl8lLHseYTSwOQ3iBYDnmB+RwKKWAUJxEZndrPymo72UQHQ
 vUn3YqwVunLc6q853s8QXByKhubEGbCp5dvylDOpq5cpzlCS2QHdqwnmda4SmuTJTD
 lla7G5umeoDzd0coruxkMJM0FaGmP4PJk/PnWhJhrzUnoa8FhnFJTjDfge505h9kfI
 Ehgz5aH47U7fA==
X-CNFS-Analysis: v=2.4 cv=d4pWygjE c=1 sm=1 tr=0 ts=65db85b0 cx=a_exe
 a=ysqyREb6S0hakrSWcZdePw==:117 a=ysqyREb6S0hakrSWcZdePw==:17 a=A1X0JdhQAAAA:8
 a=XkRKQH6RAAAA:8 a=xNf9USuDAAAA:8 a=jpfQ5zAA-lF3Itj3ug0A:9 a=CjuIK1q_8ugA:10
 a=S9t9CVBMNsWLYKe4UCoA:9 a=Df3jFdWbhGDLdZNm0fyq:22 a=1gUyE30hU_ULiMxJiLUW:22
 a=SEwjQc04WA-l_NiBhQ7s:22
Date: Sun, 25 Feb 2024 19:22:50 +0100
From: g1pi@libero.it
To: qemu-devel@nongnu.org
Subject: possible race condition in qemu nat layer or virtio-net
Message-ID: <ZduFeuu-QvWe6OG7@moon>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="poLAErXQDklQCV3C"
Content-Disposition: inline
X-CMAE-Envelope: MS4xfFCJ2Q43oTylWpb1wwmTLDxQH3FBYDr/FhC/MRXeWlWhlcBYj4FY+KwLTVVxKxNm0yJsrtZ9lRaNhX/IjHiT7SsVNHWF+/xr3OA5glACepNZmvdkAQ7G
 hsw2gyMiPiUaWeWopiy5ZzYxPBQaE8sTV97Wy9mF3J5eRNc00KONhWTiNiA4fxP0yFvZHFz7mrbL+R2NATE3P+YF6RxsVMPBxCs=
Received-SPF: pass client-ip=213.209.13.31; envelope-from=g1pi@libero.it;
 helo=libero.it
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 25 Feb 2024 16:02:42 -0500
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


--poLAErXQDklQCV3C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all.

I believe I spotted a race condition in virtio-net or qemu/kvm (but
only when virtio-net is involved).

To replicate, one needs a virtualization environment similar to

Host:
- debian 12 x86_64, kernel 6.1.0-18-amd64
- caching name server listening on 127.0.0.1
- qemu version 7.2.9 (Debian 1:7.2+dfsg-7+deb12u5)
- command line:
    qemu-system-x86_64 \
	-enable-kvm \
	-daemonize \
	-parallel none \
	-serial none \
	-m 256 \
	-drive if=virtio,format=raw,file=void.raw \
	-monitor unix:run/void.mon,server,nowait \
	-nic user,model=virtio,hostfwd=tcp:127.0.0.1:3822-:22

Guest:
- x86_64, linux/musl or linux/glibc or freebsd or openbsd
- /etc/resolv.conf:
    nameserver 10.0.2.2         i.e. the caching dns in the host
    nameserver 192.168.1.123    non existent

and run the attached program in the guest.

The program opens a UDP socket, sends out a bunch of (dns) requests,
poll()s on the socket, and then receives the responses.

If a delay is inserted between the sendto() calls, the (unique) response
from the host is received correctly:

    $ ./a.out 10.0.2.2 >/dev/null # to warm up the host cache
    $ ./a.out 10.0.2.2 delay 192.168.1.123
    poll: 1 1 1
    recvfrom() 45
    <response packet>
    recvfrom() -1

If the sento()s are performed in short order, the response packet
gets lost:

    $ ./a.out 10.0.2.2 >/dev/null # to warm up the host cache
    $ ./a.out 10.0.2.2 192.168.1.123
    poll: 0 1 0
    recvfrom() -1
    recvfrom() -1

A tcpdump capture on the host side shows no difference between the two cases.

Tcpdump on the guest side is another story: in the good case, it looks like
this

7:32:44.332 IP 10.0.2.15.43276 > 10.0.2.2.53: 33452+ A? example.com. (29)
7:32:44.333 IP 10.0.2.2.53 > 10.0.2.15.43276: 33452 1/0/0 A 93.184.216.34 (45)
7:32:44.349 IP 10.0.2.15.43276 > 192.168.1.123.53: 33452+ A? example.com. (29)

while in the bad case it looks like this

7:32:55.358 IP 10.0.2.15.46537 > 10.0.2.2.53: 33452+ A? example.com. (29)
7:32:55.358 IP 10.0.2.15.46537 > 192.168.1.123.53: 33452+ A? example.com. (29)
7:32:55.358 IP *127.0.0.1*.53 > 10.0.2.15.46537: 33452 1/0/0 A 93.184.216.34 (45)

where the response packet has wrong src ip.

Looks like a failure of the NAT layer, but it does not happen when
the guest uses another emulated network driver: don't know whether it's
because the relevant code is in virtio-net or because other drivers add
overhead that masks the issue.

There's nothing special in port 53: I was just investigating
a weird failure in name resolution in a MUSL based guest
(https://www.openwall.com/lists/musl/2024/02/17/3) and wrote the program
to mimic MUSL resolver's behaviour.

But it succeeds/fails consistently with a different port, and in all
guests I tried (as long as the emulated network device is virtio-net).

To see the issue, it's important that the response to the first request
is so fast that it's simultaneous with the second request: that's the reason
behind the caching nameserver in the host.

I also opened a bug report to debian
(https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1064634).

I'm not subscribed to qemu-devel, so please CC me in replies.

Best regards,
        g.b.

--poLAErXQDklQCV3C
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="m.c"

#include <stdio.h>
#include <time.h>
#include <poll.h>
#include <assert.h>
#include <string.h>

#include <arpa/inet.h>
#include <netdb.h>
#include <netinet/in.h>
#include <sys/socket.h>
#include <sys/socket.h>
#include <sys/types.h>

static void dump(const char *s, size_t len) {
    while (len--) {
        char t = *s++;
        if (' ' <= t && t <= '~' && t != '\\')
            printf("%c", t);
        else
            printf("\\%o", t & 0xff);
    }
    printf("\n");
}

int main(int argc, char *argv[]) {
    int sock, rv, n;
    const char req[] =
        "\202\254\1\0\0\1\0\0\0\0\0\0\7example\3com\0\0\1\0\1";
    struct timespec delay_l = { 1, 0 }; /* 1 sec */
    struct pollfd pfs;
    struct sockaddr_in me = { 0 };

    sock = socket(AF_INET, SOCK_DGRAM | SOCK_CLOEXEC | SOCK_NONBLOCK,
                  IPPROTO_IP);
    assert(sock >= 0);

    me.sin_family = AF_INET;
    me.sin_port = 0;
    me.sin_addr.s_addr = inet_addr("0.0.0.0");
    rv = bind(sock, (struct sockaddr *) &me, sizeof me);
    assert(0 == rv);

    for (n = 1; n < argc; n++) {
        if (0 == strcmp("delay", argv[n])) {
            struct timespec delay_s = { 0, (1 << 24) }; /* ~ 16 msec */
            nanosleep(&delay_s, NULL);
        } else {
            struct sockaddr_in dst = { 0 };
            dst.sin_family = AF_INET;
            dst.sin_port = htons(53);
            dst.sin_addr.s_addr = inet_addr(argv[n]);
            rv = sendto(sock, req, sizeof req - 1, MSG_NOSIGNAL,
                        (struct sockaddr *) &dst, sizeof dst);
            assert(rv >= 0);
        }
    }

    nanosleep(&delay_l, NULL);
    pfs.fd = sock;
    pfs.events = POLLIN;
    rv = poll(&pfs, 1, 2000);
    printf("poll: %d %d %d\n", rv, pfs.events, pfs.revents);

    for (n = 1; n < argc; n++) {
        char resp[4000];
        if (0 == strcmp("delay", argv[n]))
            continue;
        rv = recvfrom(sock, resp, sizeof resp, 0, NULL, NULL);
        printf("recvfrom() %d\n", rv);
        if (rv > 0)
            dump(resp, rv);
    }

    return 0;
}

--poLAErXQDklQCV3C--

