Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3E71EF9002
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 16:10:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxooD-0005ot-Iq; Wed, 04 Mar 2026 11:10:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vxoo9-0005m9-Mw
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:10:45 -0500
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vxoo6-0001oA-0T
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 11:10:45 -0500
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:a189:0:640:4da6:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 50765C01B0;
 Wed, 04 Mar 2026 19:10:36 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:921::1:1b] (unknown
 [2a02:6bf:8080:921::1:1b])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id YAr0b50AtuQ0-Fu5AUcE8; Wed, 04 Mar 2026 19:10:35 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1772640635;
 bh=8UD8cQ3tm8oVuLOgWzE+de3qaO/cNDFB8wOJUoCzvfg=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=Yl3wXTse5EKPhmHGvChgiZN/Zll//AblvyFQp6WF6/dl5m54fkAJtZXuSg1nt8uUp
 BoBqmImmbekuwW21q6R+oCqs6za9pcL4JmaAUL470CrZIAFyNiYt0pwoJEjJebI2Ht
 QdorkEabFnnqM5vRj3xViMD2AX53wXwboUsQ4aDk=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <767d19a5-29f5-44fb-bbe5-0616467f7b7a@yandex-team.ru>
Date: Wed, 4 Mar 2026 19:10:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/16] migration: vmstate_save/load_state(): stop
 tracing errors
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>
References: <20260220210214.800050-1-vsementsov@yandex-team.ru>
 <20260220210214.800050-6-vsementsov@yandex-team.ru> <878qcdu7q7.fsf@suse.de>
 <aab6nr_Sgx2tZcOI@x1.local>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aab6nr_Sgx2tZcOI@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
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

On 03.03.26 18:13, Peter Xu wrote:
> On Fri, Feb 27, 2026 at 07:44:48PM -0300, Fabiano Rosas wrote:
>> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
>>
>>> We duplicate some of errors by trace points. That doesn't make
>>> real sense: we report the error through errp, and stop migration,
>>> no reason to duplicate the reported error by trace points, making
>>> error path more complicated.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>> ---
>>>   migration/trace-events |  5 ++---
>>>   migration/vmstate.c    | 14 ++++++--------
>>>   2 files changed, 8 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/migration/trace-events b/migration/trace-events
>>> index 90629f828f..e864d19c55 100644
>>> --- a/migration/trace-events
>>> +++ b/migration/trace-events
>>> @@ -55,15 +55,14 @@ postcopy_pause_incoming_continued(void) ""
>>>   postcopy_page_req_sync(void *host_addr) "sync page req %p"
>>>   
>>>   # vmstate.c
>>> -vmstate_load_field_error(const char *field, int ret) "field \"%s\" load failed, ret = %d"
>>>   vmstate_load_state(const char *name, int version_id) "%s v%d"
>>> -vmstate_load_state_end(const char *name, const char *reason, int val) "%s %s/%d"
>>> +vmstate_load_state_end(const char *name) "%s"
>>>   vmstate_load_state_field(const char *name, const char *field, bool exists) "%s:%s exists=%d"
>>>   vmstate_n_elems(const char *name, int n_elems) "%s: %d"
>>>   vmstate_subsection_load(const char *parent) "%s"
>>>   vmstate_subsection_load_bad(const char *parent,  const char *sub, const char *sub2) "%s: %s/%s"
>>>   vmstate_subsection_load_good(const char *parent) "%s"
>>> -vmstate_save_state_pre_save_res(const char *name, int res) "%s/%d"
>>> +vmstate_save_state_pre_save_done(const char *name) "%s"
>>>   vmstate_save_state_loop(const char *name, const char *field, int n_elems) "%s/%s[%d]"
>>>   vmstate_save_state_top(const char *idstr) "%s"
>>>   vmstate_subsection_save_loop(const char *name, const char *sub) "%s/%s"
>>> diff --git a/migration/vmstate.c b/migration/vmstate.c
>>> index dd7cd27993..b07bbdd366 100644
>>> --- a/migration/vmstate.c
>>> +++ b/migration/vmstate.c
>>> @@ -144,7 +144,6 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
>>>           error_setg(errp, "%s: incoming version_id %d is too new "
>>>                      "for local version_id %d",
>>>                      vmsd->name, version_id, vmsd->version_id);
>>> -        trace_vmstate_load_state_end(vmsd->name, "too new", -EINVAL);
>>>           return -EINVAL;
>>>       }
>>>   
>>> @@ -152,7 +151,6 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
>>>           error_setg(errp, "%s: incoming version_id %d is too old "
>>>                      "for local minimum version_id %d",
>>>                      vmsd->name, version_id, vmsd->minimum_version_id);
>>> -        trace_vmstate_load_state_end(vmsd->name, "too old", -EINVAL);
>>>           return -EINVAL;
>>>       }
>>>   
>>> @@ -245,7 +243,6 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
>>>   
>>>                   if (ret < 0) {
>>>                       qemu_file_set_error(f, ret);
>>> -                    trace_vmstate_load_field_error(field->name, ret);
>>>                       return ret;
>>>                   }
>>>               }
>>> @@ -269,7 +266,7 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
>>>               error_prepend(errp, "post load hook failed for: %s, version_id: "
>>>                             "%d, minimum_version: %d: ", vmsd->name,
>>>                             vmsd->version_id, vmsd->minimum_version_id);
>>> -            ret = -EINVAL;
>>> +            return -EINVAL;
>>>           }
>>>       } else if (vmsd->post_load) {
>>>           ret = vmsd->post_load(opaque, version_id);
>>> @@ -279,12 +276,13 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
>>>                          "minimum_version: %d, ret: %d",
>>>                          vmsd->name, vmsd->version_id, vmsd->minimum_version_id,
>>>                          ret);
>>> +            return ret;
>>>           }
>>>       }
>>>   
>>> -    trace_vmstate_load_state_end(vmsd->name, "end", ret);
>>> +    trace_vmstate_load_state_end(vmsd->name);
>>>   
>>> -    return ret;
>>> +    return 0;
>>>   }
>>>   
>>>   static int vmfield_name_num(const VMStateField *start,
>>> @@ -444,20 +442,20 @@ static int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
>>>   
>>>       if (vmsd->pre_save_errp) {
>>>           ret = vmsd->pre_save_errp(opaque, errp) ? 0 : -EINVAL;
>>> -        trace_vmstate_save_state_pre_save_res(vmsd->name, ret);
>>>           if (ret < 0) {
>>>               error_prepend(errp, "pre-save for %s failed: ", vmsd->name);
>>>               return ret;
>>>           }
>>>       } else if (vmsd->pre_save) {
>>>           ret = vmsd->pre_save(opaque);
>>> -        trace_vmstate_save_state_pre_save_res(vmsd->name, ret);
>>>           if (ret) {
>>>               error_setg(errp, "pre-save failed: %s", vmsd->name);
>>>               return ret;
>>>           }
>>>       }
>>>   
>>> +    trace_vmstate_save_state_pre_save_done(vmsd->name);
>>> +
>>>       if (vmdesc) {
>>>           json_writer_str(vmdesc, "vmsd_name", vmsd->name);
>>>           json_writer_int64(vmdesc, "version", version_id);
>>
>> One benefit of the traces is to be able to match with source code when
>> debugging a QEMU instance that cannot be rebuilt. Not so much about the
>> trace itself, but to be able to know _where_ the code exited.
> 
> Yep.  If we have them already and not yet too messy, shall we keep it?
> 

Ok, let's keep




-- 
Best regards,
Vladimir

