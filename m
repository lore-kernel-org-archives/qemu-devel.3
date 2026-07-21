Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0529C44529
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 06:59:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm4Rg-0005Su-Ta; Tue, 21 Jul 2026 02:59:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wm4Rf-0005Sh-Ar
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 02:59:15 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wm4Rc-0007tZ-7H
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 02:59:15 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
 by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id 07E658079D;
 Tue, 21 Jul 2026 09:59:07 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:45b::1:22] (unknown
 [2a02:6bf:8080:45b::1:22])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id 5xP2eD2XR4Y0-mxzuURl3; Tue, 21 Jul 2026 09:59:06 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1784617146;
 bh=AQbuOt3G+i4umJ0kwWyDpT+borce9eXz+5X51fVaO6c=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=V885/eY+oE0cHyp3fBWX3m4Jf7bHgMQifg0loKBSsdhfFcMn8UNKVWz52UyaeRxAZ
 5ZJ0Vm/oRJ30WECUqVLUU+mJV+T6wfeVY3WoczyEjxBgWSjejaaKpR2YBkhGT5edPA
 F8XIanW/KbZ9NKje8v0Zh0WuDbuL9k1e8lt+C34g=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <b788b7cb-df52-4397-ad3c-a0eb695d8d46@yandex-team.ru>
Date: Tue, 21 Jul 2026 09:59:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 01/15] net/tap: rework tap_parse_script
To: Markus Armbruster <armbru@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, peterx@redhat.com, farosas@suse.de,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com, qemu-devel@nongnu.org,
 berrange@redhat.com, pbonzini@redhat.com, yc-core@yandex-team.ru,
 mark.caveayland@nutanix.com, Jason Wang <jasowangio@gmail.com>
References: <20260714154246.1242856-1-vsementsov@yandex-team.ru>
 <20260714154246.1242856-2-vsementsov@yandex-team.ru>
 <87wluoswnf.fsf@pond.sub.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87wluoswnf.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

On 21.07.26 09:07, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
>> Factor out tap_is_explicit_no_script() helper, to simplify
>> further changes.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>   net/tap.c | 27 +++++++++++++++++++++------
>>   1 file changed, 21 insertions(+), 6 deletions(-)
>>
>> diff --git a/net/tap.c b/net/tap.c
>> index 57ffb09885c..fedd48c48d2 100644
>> --- a/net/tap.c
>> +++ b/net/tap.c
>> @@ -92,19 +92,34 @@ static void launch_script(const char *setup_script, const char *ifname,
>>   static void tap_send(void *opaque);
>>   static void tap_writable(void *opaque);
>>   
>> -static char *tap_parse_script(const char *script_arg, const char *default_path)
>> +static bool tap_is_explicit_no_script(const char *script_arg)
>>   {
>> -    g_autofree char *res = g_strdup(script_arg);
>> +    if (!script_arg) {
>> +        return false;
>> +    }
>>   
>> -    if (!res) {
>> -        res = get_relocated_path(default_path);
>> +    if (script_arg[0] == '\0') {
>> +        return true;
>> +    }
>> +
>> +    if (strcmp(script_arg, "no") == 0) {
>> +        return true;
>>       }
>>   
>> -    if (res[0] == '\0' || strcmp(res, "no") == 0) {
>> +    return false;
>> +}
>> +
>> +static char *tap_parse_script(const char *script_arg, const char *default_path)
>> +{
>> +    if (tap_is_explicit_no_script(script_arg)) {
>>           return NULL;
>>       }
>>   
>> -    return g_steal_pointer(&res);
>> +    if (!script_arg) {
>> +        return get_relocated_path(default_path);
>> +    }
>> +
>> +    return g_strdup(script_arg);
>>   }
>>   
>>   static void tap_update_fd_handler(TAPState *s)
> 
> Before the patch, we default @script_arg to get_relocated_path(default)
> first, then check for "" or "no".  After the patch, we do it the other
> way round.  Works, because get_relocated_path() never returns "" or
> "no".  Worth mentioning in the commit message?

Will mention it

> 
> The new order feels slightly clearer to me.
> 
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> 

Thanks!

-- 
Best regards,
Vladimir

