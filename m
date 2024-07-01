Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82FC7C3065A
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 06:51:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOAsJ-0007Dg-6Z; Mon, 01 Jul 2024 02:50:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sOAsH-0007Cv-Jq; Mon, 01 Jul 2024 02:50:53 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sOAsE-0000lB-EX; Mon, 01 Jul 2024 02:50:53 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:2799:0:640:ddd6:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 82D8660D1A;
 Mon,  1 Jul 2024 09:50:43 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:6415::1:19] (unknown
 [2a02:6b8:b081:6415::1:19])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id goOPgW1IbOs0-rBQQjRHA; Mon, 01 Jul 2024 09:50:42 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1719816642;
 bh=tx1NkXJw/PRcstcBCXYVPyag3VtBuH6FFquqH9SCiFI=;
 h=In-Reply-To:Cc:Date:References:To:From:Subject:Message-ID;
 b=rBUHgiUKZ8jhNKh/T0QjUBsgQP1AEoCFAruaO4TrarKGsW2I8whWlpqcQAeDyXq5L
 IBELVZTWkdmOXrEG71zmtm8AxZdVUcWrBNLXF4kkaA5rEFfAB2CQxGo+y7rx5HJCU4
 /Wte41p0N/A+T2Ec6F1MdFBE7tjNHgSjKqXtGthw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <c6cb63ae-75e0-44c3-922a-bc11ef7390c2@yandex-team.ru>
Date: Mon, 1 Jul 2024 09:50:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block/curl: use strlen instead of strchr
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 qemu-trivial@nongnu.org
References: <20240628054942.657397-1-vsementsov@yandex-team.ru>
 <03e1eb96-49ce-48bb-adc7-6ea3fb843b48@tls.msk.ru>
 <1eb734b7-73a3-40d7-9e3d-7352b7be3940@yandex-team.ru>
Content-Language: en-US
In-Reply-To: <1eb734b7-73a3-40d7-9e3d-7352b7be3940@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 01.07.24 09:34, Vladimir Sementsov-Ogievskiy wrote:
> On 29.06.24 09:20, Michael Tokarev wrote:
>> On 6/28/24 08:49, Vladimir Sementsov-Ogievskiy wrote:
>>> We already know where colon is, so no reason to search for it. Also,
>>> avoid a code, which looks like we forget to check return value of
>>> strchr() to NULL.
>>>
>>> Suggested-by: Kevin Wolf <kwolf@redhat.com>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>> ---
>>>
>>> This replaces my patch
>>>    [PATCH] block/curl: explicitly assert that strchr returns non-NULL value
>>> Supersedes: <20240627153059.589070-1-vsementsov@yandex-team.ru>
>>>
>>>   block/curl.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/block/curl.c b/block/curl.c
>>> index 419f7c89ef..d03bfe4817 100644
>>> --- a/block/curl.c
>>> +++ b/block/curl.c
>>> @@ -219,7 +219,7 @@ static size_t curl_header_cb(void *ptr, size_t size, size_t nmemb, void *opaque)
>>>           && g_ascii_strncasecmp(header, accept_ranges,
>>>                                  strlen(accept_ranges)) == 0) {
>>> -        char *p = strchr(header, ':') + 1;
>>> +        char *p = header + strlen(accept_ranges);
>>>           /* Skip whitespace between the header name and value. */
>>>           while (p < end && *p && g_ascii_isspace(*p)) {
>>
>> Heck.  All these strlen()s look ugly, especially in the
>> loop iterations..
> 
> I expect that strlen of string constant is calculated in compilation time.
> 
> My aim was to fix Coverity complain (I don't see this complain in public qemu coverity project, that's why I don't specify CID in commit message), not to rewrite the whole function. So I'd prefer Kevein's suggesting which is both minimal and makes the code obviously correct.. The only simpler thing is to mark the problem false-positive in Coverity.
> 


Upd: I missed that you sent a patch, this changes things. Of course, you code looks nicer than old one.

-- 
Best regards,
Vladimir


