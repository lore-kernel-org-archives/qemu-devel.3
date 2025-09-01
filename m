Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2FAACA0FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 09:37:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut0xP-0006RR-Vj; Mon, 01 Sep 2025 05:36:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1ut0xN-0006LD-V1
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 05:36:10 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1ut0xG-00063a-1r
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 05:36:09 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:999c:0:640:51a7:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id ECE9780822;
 Mon, 01 Sep 2025 12:35:51 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:12c::1:9] (unknown [2a02:6bf:8080:12c::1:9])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id mZapN63GpOs0-42DChIi1; Mon, 01 Sep 2025 12:35:51 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1756719351;
 bh=g3P3p6YXWLb/YvfxnGIz42MPAAnuWlOtE935zULdSOs=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=qmevJeeytIsC8mJfD71LPvVxd38jq+cVZsRdul5nTI8dJSbWfJ3cx9LQEDPL/OQvf
 ++n2HIrzcL+QbStZTlTA4NOvAAMuTLEaYOTm8cqODzEXknGHIAMUVbhA/A/4hiQtMV
 OVUplbkprQg//FGMq8JFtlb9u/nQgziwpCy13S2M=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <e54b8dde-1b77-4bbd-aca6-221a747f24d3@yandex-team.ru>
Date: Mon, 1 Sep 2025 12:35:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 5/9] migration: Thread-ify precopy vmstate load process
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dave@treblig.org>,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Hailiang Zhang <zhanghailiang@xfusion.com>,
 Yury Kotov <yury-kotov@yandex-team.ru>, Prasad Pandit <ppandit@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Juraj Marcin <jmarcin@redhat.com>
References: <20250827205949.364606-1-peterx@redhat.com>
 <20250827205949.364606-6-peterx@redhat.com>
 <a7f72cc7-d5ec-4a9e-a1a1-d77f376c5ce4@yandex-team.ru>
 <aLHgmt7vDbmWCS24@x1.local>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aLHgmt7vDbmWCS24@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 29.08.25 20:17, Peter Xu wrote:
> On Fri, Aug 29, 2025 at 11:29:59AM +0300, Vladimir Sementsov-Ogievskiy wrote:
>>> For that, qemu_loadvm_state() and qemu_loadvm_state_main() functions need
>>> to now take a "bql_held" parameter saying whether bql is held.  We could
>>> use things like BQL_LOCK_GUARD(), but this patch goes with explicit
>>> lockings rather than relying on bql_locked TLS variable.  In case of
>>> migration, we always know whether BQL is held in different context as long
>>> as we can still pass that information downwards.
>>
>> Agree, but I think it's better to make new macros following same pattern, i.e.
>>
>> WITH_BQL_HELD(bql_held) {
>>      action();
>> }
>>
>> instead of
>>
>> WITH_BQL_HELD(bql_held, actions());
>>
>> ..
>>
>> Or I'm missing something and we already have a precedent of the latter
>> notation?
> 
> Nop.. it's just that when initially working on that I didn't try as hard to
> achieve such pattern.  Here we need to recover the BQL status after the
> block, so I didn't immediately see how autoptr would work there.
> 
> But I tried slightly harder, I think below should achieve the same pattern
> but based on some for() magic.
> 
> Thanks for raising this, early comments still be welcomed or I'll go with
> that.
> 
> ===8<===
> 
> static inline void
> with_bql_held_lock(bool bql_held, const char *file, int line)
> {
>      assert(bql_held == bql_locked());
>      if (!bql_held) {
>          bql_lock_impl(file, line);
>      }
> }
> 
> static inline void
> with_bql_held_unlock(bool bql_held)
> {
>      assert(bql_locked());
>      if (!bql_held) {
>          bql_unlock();
>      }
> }
> 
> /**
>   * WITH_BQL_HELD(): Run a block of code, making sure BQL is held
>   * @bql_held: Whether BQL is already held
>   *
>   * Example use case:
>   *
>   * WITH_BQL_HELD(bql_held) {
>   *     // BQL is guaranteed to be held within this block,
>   *     // if it wasn't held, will be released when the block finishes.
>   * }
>   */
> #define  WITH_BQL_HELD(bql_held)                                \
>      for (bool _bql_once = \
>               (with_bql_held_lock(bql_held, __FILE__, __LINE__), true);  \
>           _bql_once;                                                     \
>           _bql_once = (with_bql_held_unlock(bql_held), false))           \
> 
> static inline void
> with_bql_released_unlock(bool bql_held)
> {
>      assert(bql_held == bql_locked());
>      if (bql_held) {
>          bql_unlock();
>      }
> }
> 
> static inline void
> with_bql_released_lock(bool bql_held, const char *file, int line)
> {
>      assert(!bql_locked());
>      if (bql_held) {
>          bql_lock_impl(file, line);
>      }
> }
> 
> /**
>   * WITH_BQL_RELEASED(): Run a task, making sure BQL is released
>   * @bql_held: Whether BQL is already held
>   *
>   * Example use case:
>   *
>   * WITH_BQL_RELEASED(bql_held) {
>   *     // BQL is guaranteed to be released within this block,
>   *     // if it was held, will be re-taken when the block finishes.
>   * }
>   */
> #define  WITH_BQL_RELEASED(bql_held)                                    \
>      for (bool _bql_once = (with_bql_released_unlock(bql_held), true);   \
>           _bql_once;                                                     \
>           _bql_once =                                                    \
>               (with_bql_released_lock(bql_held, __FILE__, __LINE__), false)) \
> 


Hm, still it's doesn't achieve same magic as WITH_QEMU_LOCK_GUARD, as we cant use
"return" inside this for-loop (may be not critical, as you anyway don't use it..)

Something like this should work I think:

static inline BQLLockAutoCond *bql_auto_lock_cond(bool bql_held, const char *file, int line)
{
     assert(bql_held == bql_locked());
     if (bql_held) {
         return (BQLLockAutoCond *)(uintptr_t)2;
     }
     bql_lock_impl(file, line);
     return (BQLLockAutoCond *)(uintptr_t)1;
}

static inline void bql_auto_unlock_cond(BQLLockAutoCond *l)
{
     if (l == (BQLLockAutoCond *)(uintptr_t)1) {
         bql_unlock();
     }
}

G_DEFINE_AUTOPTR_CLEANUP_FUNC(BQLLockAutoCond, bql_auto_unlock_cond)

#define WITH_BQL_HELD_(bql_held, var) \
     for (g_autoptr(BQLLockAutoCond) var = \
              bql_auto_lock_cond(bql_held, __FILE__, __LINE__); \
          var; \
          bql_auto_unlock_cond(var), var = NULL)

#define WITH_BQL_HELD(bql_held) \
     WITH_BQL_HELD_((bql_held), glue(bql_held_cond_auto, __COUNTER__))



-- 
Best regards,
Vladimir

