Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF393C25B79
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 20:55:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBhN8-0005xa-98; Mon, 27 May 2024 16:55:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sBhN6-0005wx-1e; Mon, 27 May 2024 16:55:08 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sBhN3-00005F-FL; Mon, 27 May 2024 16:55:07 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 378884E600E;
 Mon, 27 May 2024 22:55:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id XBzI5CHcfZio; Mon, 27 May 2024 22:55:01 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 385144E6005; Mon, 27 May 2024 22:55:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 362FC746E3B;
 Mon, 27 May 2024 22:55:01 +0200 (CEST)
Date: Mon, 27 May 2024 22:55:01 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
cc: Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH 00/43] Remaining MMU clean up patches
In-Reply-To: <cover.1716763435.git.balaton@eik.bme.hu>
Message-ID: <3adb5c1b-5dfb-1d4d-fccc-0ac0b3df595b@eik.bme.hu>
References: <cover.1716763435.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, 27 May 2024, BALATON Zoltan wrote:
> This is the rest of the MMU clean up series the first part of which
> was merged. Here are the remaining patches rebased and some more added.

Besides cleaning up this code my other goal with this and previous already 
merged series was trying to optimise this a bit. Here are some numbers 
I've got with 9.0 compared to after this series. I've got these running 
old benchmarks that do a lot of memory accesses under AmigaOS on sam460ex 
and amigaone machines. The speed up is not much but measurable.

***
sam460ex:
QEMU v9.0.0
===========
    Sieve of Eratosthenes (Scaled to 10 Iterations)
    Version 1.2, 03 April 1992

    Array Size   Number   Last Prime    Linear     RunTime    MIPS
     (Bytes)   of Primes               Time(sec)    (Sec)
        8191       1899        16381   0.001068   0.001068  1552.2
       10000       2261        19997   0.001304   0.001373  1479.5
       20000       4202        39989   0.002608   0.002747  1498.7
       40000       7836        79999   0.005216   0.005493  1517.0
       80000      14683       160001   0.010432   0.010681  1578.4
      160000      27607       319993   0.020864   0.241089   141.4
      320000      52073       639997   0.041728   0.799561    86.2
      640000      98609      1279997   0.083457   2.019043    68.9
     1280000     187133      2559989   0.166913   4.824219    58.2
     2560000     356243      5119997   0.333827  11.142578    50.9
     5120000     679460     10239989   0.667654  25.488281    44.9
    10240000    1299068     20479999   1.335307  55.898438    41.2
    20480000    2488465     40960001   2.670614  125.625000    37.0

    Average RunTime = 0.020496 (sec)
    High  MIPS      =   1578.4
    Low   MIPS      =     37.0

STREAM version $Revision: 5.10 $
Your clock granularity/precision appears to be 3 microseconds.
Each test below will take on the order of 228749 microseconds.
    (= 76249 clock ticks)
Function    Best Rate MB/s  Avg time     Min time     Max time
Copy:            1703.0     0.097710     0.093951     0.107887
Scale:            706.9     0.233270     0.226353     0.244723
Add:              862.8     0.288949     0.278165     0.302902
Triad:            763.4     0.318530     0.314394     0.324167

QEMU master + this series:
==========================
    Sieve of Eratosthenes (Scaled to 10 Iterations)
    Version 1.2, 03 April 1992

    Array Size   Number   Last Prime    Linear     RunTime    MIPS
     (Bytes)   of Primes               Time(sec)    (Sec)
        8191       1899        16381   0.001068   0.001068  1552.2
       10000       2261        19997   0.001304   0.001259  1614.0
       20000       4202        39989   0.002608   0.002518  1635.0
       40000       7836        79999   0.005216   0.005493  1517.0
       80000      14683       160001   0.010432   0.011597  1453.8
      160000      27607       319993   0.020864   0.218506   156.0
      320000      52073       639997   0.041728   0.747070    92.2
      640000      98609      1279997   0.083457   1.887207    73.7
     1280000     187133      2559989   0.166913   4.633789    60.6
     2560000     356243      5119997   0.333827  10.449219    54.2
     5120000     679460     10239989   0.667654  23.750000    48.1
    10240000    1299068     20479999   1.335307  52.109375    44.2
    20480000    2488465     40960001   2.670614  117.031250    39.7

    Relative to 10 Iterations and the 8191 Array Size:
    Average RunTime = 0.019190 (sec)
    High  MIPS      =   1635.0
    Low   MIPS      =     39.7

STREAM version $Revision: 5.10 $
Your clock granularity/precision appears to be 3 microseconds.
Each test below will take on the order of 189202 microseconds.
    (= 63067 clock ticks)
Function    Best Rate MB/s  Avg time     Min time     Max time
Copy:            1730.8     0.096015     0.092444     0.107926
Scale:            784.4     0.208925     0.203969     0.217610
Add:             1002.6     0.243805     0.239389     0.254176
Triad:            768.9     0.322526     0.312154     0.345777

***
amigaone:
QEMU v9.0.0
===========
    Sieve of Eratosthenes (Scaled to 10 Iterations)
    Version 1.2, 03 April 1992

    Array Size   Number   Last Prime    Linear     RunTime    MIPS
     (Bytes)   of Primes               Time(sec)    (Sec)
        8191       1899        16381   0.001068   0.001068  1552.2
       10000       2261        19997   0.001304   0.001259  1614.0
       20000       4202        39989   0.002608   0.002747  1498.7
       40000       7836        79999   0.005216   0.005493  1517.0
       80000      14683       160001   0.010432   0.010986  1534.6
      160000      27607       319993   0.020864   0.023193  1469.7
      320000      52073       639997   0.041728   0.047607  1446.9
      640000      98609      1279997   0.083457   0.100098  1389.9
     1280000     187133      2559989   0.166913   0.200195  1403.0
     2560000     356243      5119997   0.333827   0.400391  1415.6
     5120000     679460     10239989   0.667654   1.484375   770.2
    10240000    1299068     20479999   1.335307   1.679688  1372.5
    20480000    2488465     40960001   2.670614   6.796875   683.7

    Relative to 10 Iterations and the 8191 Array Size:
    Average RunTime = 0.001397 (sec)
    High  MIPS      =   1614.0
    Low   MIPS      =    683.7

STREAM version $Revision: 5.10 $
Your clock granularity/precision appears to be 2 microseconds.
Each test below will take on the order of 203076 microseconds.
    (= 101538 clock ticks)
Function    Best Rate MB/s  Avg time     Min time     Max time
Copy:            2529.4     0.067538     0.063255     0.079943
Scale:            885.4     0.187032     0.180708     0.194940
Add:             1119.5     0.226545     0.214384     0.246212
Triad:            959.5     0.260417     0.250131     0.281227

QEMU master + this series:
==========================
    Sieve of Eratosthenes (Scaled to 10 Iterations)
    Version 1.2, 03 April 1992

    Array Size   Number   Last Prime    Linear     RunTime    MIPS
     (Bytes)   of Primes               Time(sec)    (Sec)
        8191       1899        16381   0.001068   0.001068  1552.2
       10000       2261        19997   0.001304   0.001373  1479.5
       20000       4202        39989   0.002608   0.002518  1635.0
       40000       7836        79999   0.005216   0.005798  1437.2
       80000      14683       160001   0.010432   0.010986  1534.6
      160000      27607       319993   0.020864   0.021973  1551.3
      320000      52073       639997   0.041728   0.046387  1485.0
      640000      98609      1279997   0.083457   0.100098  1389.9
     1280000     187133      2559989   0.166913   0.200195  1403.0
     2560000     356243      5119997   0.333827   0.400391  1415.6
     5120000     679460     10239989   0.667654   0.859375  1330.4
    10240000    1299068     20479999   1.335307   3.085938   747.1
    20480000    2488465     40960001   2.670614   6.562500   708.1

    Relative to 10 Iterations and the 8191 Array Size:
    Average RunTime = 0.001397 (sec)
    High  MIPS      =   1635.0
    Low   MIPS      =    708.1

STREAM version $Revision: 5.10 $
Your clock granularity/precision appears to be 2 microseconds.
Each test below will take on the order of 168572 microseconds.
    (= 84286 clock ticks)
Function    Best Rate MB/s  Avg time     Min time     Max time
Copy:            2410.2     0.076613     0.066384     0.127486
Scale:           1007.6     0.164015     0.158791     0.175446
Add:             1236.3     0.203815     0.194123     0.216319
Triad:            967.6     0.262833     0.248042     0.281844

There is some variation between results between multiple runs but the 
optimised version seems to run a bit faster and it should be more readable 
code than it was before. It could be possible to improve it further but I 
stop here for now.

The sam460ex seems to be slower due to TLB misses generating an exception 
on embedded PPC and exceptions are slow on QEMU (not only because of 
needing to go through guest code but generally, I've also seen this with 
workloads that do a lot of syscalls but I don't have measurements of that 
now). The amigaone with G4 CPU uses hash MMU which can access the needed 
data from guest memory without an exception so it can keep running faster 
with TLB misses.

Regards,
BALATON Zoltan

