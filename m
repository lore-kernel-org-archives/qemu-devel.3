Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93055C48285
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 07:54:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rV5Q9-0006hs-O4; Wed, 31 Jan 2024 02:54:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1rV5Pz-0006hG-4x; Wed, 31 Jan 2024 02:54:00 -0500
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>)
 id 1rV5Pw-0003ws-DP; Wed, 31 Jan 2024 02:53:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1706687630; x=1707292430; i=deller@gmx.de;
 bh=OUlOUPanpqW+l3/HdWMeEiDAUtYzhO98jP1LIhhLvDo=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=c27R/Wl3syKA2vaP55deotmv810GumD9ArsX/JgD8vEs3j/HnOvVC6c9wy63KKy2
 Zu03bJkOllsZLorhRvBDf/DEECnp8jbVT/E7KS8Bbgfk9G6jdrpLTEOkcr1+XhAmw
 rf3UvGOKTL4j4Zf3vQ3Gjw6/SJ/ZQB4ar+qi81/HxrYHrMI0ToIKw7RJbjksu+UZ7
 rk8D552iDrFoE+bosi3N813E3GqC4oOSTp/Br4ap12/1UlYy/nMjTfGc9pAOvK04I
 ShMCSP/LqaYOIbqvdMAQRxE2EMMMtS5eErTJFKGBofK2Wp/QxrBt3Pqjjr+9OL0cq
 v7rlvzUTHeR060C0kg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.150.68]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1ML9uU-1rnAX13HL0-00IC3l; Wed, 31
 Jan 2024 08:53:49 +0100
Message-ID: <c96f12a4-8a36-4d40-8fd9-54e4b0284ae6@gmx.de>
Date: Wed, 31 Jan 2024 08:53:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Make TARGET_NR_setgroups affect only the
 current thread
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
References: <20240131001851.15932-1-iii@linux.ibm.com>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20240131001851.15932-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:R3UZPvfQ4nOlIQPzcUqU/Sly+irgFiNzRmuZRu6RGm/bOIERkQl
 FK0aLbuYgMcL6zqHC7LfOoq8vtFD0kFXRlJGNhPn9YOzKV5/axy5Ss+7/dKvRBfyLZxKbNX
 m5qo6fptKeCQeI0jTdQ8k4JWnK3ymyiQuX1Q9s5QNysI9Xe8Frn53etcQFjCa7oaR6frGyt
 DqadoKqE2ghQL6vtOwVog==
UI-OutboundReport: notjunk:1;M01:P0:oSqswmcm00E=;+RTEGTocZNKBLEppDJkBCEDDjiC
 xqN0swLVbouJEgQ34H0FMEG+j0iBujgnCp3pdAU7UV6yv8YgPBeDWjgZbMXeKy2Ot5aBT/f0T
 GuS/sf3HZ7DfkMzvycW3Pu8porTqOu0KC/QyX9HXD3Y8THWthVNHK41F9awxlEDus2zk3BbdP
 F2i7wTl2y6vUrTG7VdFdfFHjQiP4pa9B8UFqC/UxI80F35liHzKZJ27UnptXMqMyAUUr0szCY
 hvajUv2U6cOQPRRwJxBplKwjhKi3w9BWnZmgObvJliEr5IKHAE4glW1c5Mgsdk3SYjKXhFm5L
 xtoRBgOKH09p8SaKd0ax9xSm7Xp0m/yzzkLPLrpMKK3DzoMlWv/QiCxoibAdGMNJ+bHo3kEVW
 ggEQ2WW0sHVPe8TWegkBNDY3hXx/K/nNOBIXlA7I0w02dnVtsuDCVRcxs/qdgSh77nCCEVifA
 TRo+mWE2neKVJlFYZUTPzObiAANGi41Lb8D/DSAvJYSEoOTXKDg5zchvceji1cpmCGTj7iuYU
 dkbQ/1reTnnC1OFbBIJ/rJIhLJipc+W2LULyW4F5saI1AKj3Avy1g1leeFrOFQjL7z4rw9X4Q
 yEgMkgdCqwOpGeNZqx8UJZdxcXcxJSeCTiC0dX1yIN6ornJwtDIbfX6SgKuBJ0KZYp4jUVu/4
 8n8ispyLnanP4y62Z9acbE9BxnRrC1ZDOB/rWM9R3xZjcHR4/bIBqspy/XPDzwF+CaYmlZEUS
 /VCdXZh7lAfZ1B72WgNYjMkluwkztCUgdenePsMzeVUaIMU4MwLktoTPZTnJe9IEbFLekhegr
 KolRXD4hZU8hrhBRHMUyJsAWaXkBMQPzhYClEa4UpRJJG7N1uOKqWzYJT7rA8TLAsWhdCyn3n
 BOUB0Dey03OvoLHAE/TUEi/Vu7vuaSX+7uZOGdXdAexwjdoFqdP3WVOjHw0o4l7k8osxFL8FT
 vJPKZf1yXfdvZEtyoVv0Av33yW4=
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/31/24 01:18, Ilya Leoshkevich wrote:
> Like TARGET_NR_setuid, TARGET_NR_setgroups should affect only the
> calling thread, and not the entire process. Therefore, implement it
> using a syscall, and not a libc call.
>
> Cc: qemu-stable@nongnu.org
> Fixes: 19b84f3c35d7 ("added setgroups and getgroups syscalls")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Patch seems ok, but just out of interest, how did you noticed?

Helge


> ---
>   linux-user/syscall.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index ff245dade51..da15d727e16 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -7203,11 +7203,17 @@ static inline int tswapid(int id)
>   #else
>   #define __NR_sys_setresgid __NR_setresgid
>   #endif
> +#ifdef __NR_setgroups32
> +#define __NR_sys_setgroups __NR_setgroups32
> +#else
> +#define __NR_sys_setgroups __NR_setgroups
> +#endif
>
>   _syscall1(int, sys_setuid, uid_t, uid)
>   _syscall1(int, sys_setgid, gid_t, gid)
>   _syscall3(int, sys_setresuid, uid_t, ruid, uid_t, euid, uid_t, suid)
>   _syscall3(int, sys_setresgid, gid_t, rgid, gid_t, egid, gid_t, sgid)
> +_syscall2(int, sys_setgroups, int, size, gid_t *, grouplist)
>
>   void syscall_init(void)
>   {
> @@ -11772,7 +11778,7 @@ static abi_long do_syscall1(CPUArchState *cpu_en=
v, int num, abi_long arg1,
>                   unlock_user(target_grouplist, arg2,
>                               gidsetsize * sizeof(target_id));
>               }
> -            return get_errno(setgroups(gidsetsize, grouplist));
> +            return get_errno(sys_setgroups(gidsetsize, grouplist));
>           }
>       case TARGET_NR_fchown:
>           return get_errno(fchown(arg1, low2highuid(arg2), low2highgid(a=
rg3)));
> @@ -12108,7 +12114,7 @@ static abi_long do_syscall1(CPUArchState *cpu_en=
v, int num, abi_long arg1,
>                   }
>                   unlock_user(target_grouplist, arg2, 0);
>               }
> -            return get_errno(setgroups(gidsetsize, grouplist));
> +            return get_errno(sys_setgroups(gidsetsize, grouplist));
>           }
>   #endif
>   #ifdef TARGET_NR_fchown32


