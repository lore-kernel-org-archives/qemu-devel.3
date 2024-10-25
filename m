Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0350DD0C5F9
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 10:07:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4HD2-000183-0E; Fri, 25 Oct 2024 06:06:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1t4HD0-00017j-7M
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 06:06:18 -0400
Received: from apollo.dupie.be ([2001:bc8:3f2a:101::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1t4HCx-00071j-7D
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 06:06:17 -0400
Received: from [10.100.100.22] (6.251-180-91.adsl-dyn.isp.belgacom.be
 [91.180.251.6])
 by apollo.dupie.be (Postfix) with ESMTPSA id 243AD1520F22;
 Fri, 25 Oct 2024 12:06:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dupond.be; s=dkim;
 t=1729850767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5W3SBC77UdL1OyQAR0jxXQxeIZjeKIcAX4p0/HLnXJ4=;
 b=Hw68HvVTcXVwyCZkkMFO7iBDDtrs9Fgv/TCXHfNaHE8Ttv1VBT9frbDmvM2FK2E1LhlKT6
 WMrUg00KTBQdE7baiFNxUchfM9Q0TpL1h9x7Wy48TQrqMd4yRsWZTMO8Arz46IsK5HZsKD
 pBChhCnhxF3+LDxYvzww28ghclBDRJkXQFx8qLlUlSCGqRtu4HyW2svVd0TKzm+qxay+QZ
 gEUd/I2h+KlzO0BINd27C9y5JISCllIAWpCSAAxQoyIfCt/qYKCSbJNoNffvK08uT6e3wa
 T30NrNmcwILjUC49I6QWLAt7dY6RCxiakTVS2FwTTFxvQ9DpjniQKmPsCZkeXQ==
Message-ID: <33d6a951-033d-4827-9d85-88fba69bf839@dupond.be>
Date: Fri, 25 Oct 2024 12:06:06 +0200
MIME-Version: 1.0
User-Agent: Thunderbird Daily
Subject: Re: [PATCH] qga: skip bind mounts in fs list
From: Jean-Louis Dupond <jean-louis@dupond.be>
To: qemu-devel@nongnu.org, michael.roth@amd.com, kkostiuk@redhat.com
References: <20241002100634.162499-2-jean-louis@dupond.be>
 <b0a518bc-a600-4d0d-b1c9-5b43f95c90b9@dupond.be>
Content-Language: en-US
In-Reply-To: <b0a518bc-a600-4d0d-b1c9-5b43f95c90b9@dupond.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:bc8:3f2a:101::1;
 envelope-from=jean-louis@dupond.be; helo=apollo.dupie.be
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 9/10/2024 10:34, Jean-Louis Dupond wrote:
> On 2/10/2024 12:06, Jean-Louis Dupond wrote:
>> The filesystem list in build_fs_mount_list should skip bind mounts.
>> This because we end up in locking situations when doing fsFreeze. Like
>> mentioned in [1] and [2].
>>
>> Next to that, the build_fs_mount_list call did a fallback via
>> build_fs_mount_list_from_mtab if mountinfo did not exist.
>> There it skipped bind mounts, but this is broken for newer OS.
>> This as mounts does not return the path of the bind mount but the
>> underlying dev/partition, so S_ISDIR will never return true in
>> dev_major_minor call.
>>
>> This patch simply checks the existing devmajor:devminor tuple in the
>> mounts, and if it already exists, this means we have the same devices
>> mounted again, a bind mount. So skip this.
>>
>> Same approach is used in open-vm-tools [3].
>>
>> [1]: https://gitlab.com/qemu-project/qemu/-/issues/592
>> [2]: https://gitlab.com/qemu-project/qemu/-/issues/520
>> [3]: 
>> https://github.com/vmware/open-vm-tools/commit/d58847b497e212737007958c945af1df22a8ab58
>>
>> Signed-off-by: Jean-Louis Dupond <jean-louis@dupond.be>
>> ---
>>   qga/commands-linux.c | 25 +++++++++++++++++++++++++
>>   1 file changed, 25 insertions(+)
>>
>> diff --git a/qga/commands-linux.c b/qga/commands-linux.c
>> index 51d5e3d927..426b040ab8 100644
>> --- a/qga/commands-linux.c
>> +++ b/qga/commands-linux.c
>> @@ -59,6 +59,22 @@ static int dev_major_minor(const char *devpath,
>>       return -1;
>>   }
>>   +/*
>> + * Check if we already have the devmajor:devminor in the mounts
>> + * If thats the case return true.
>> + */
>> +static bool dev_exists(FsMountList *mounts, unsigned int devmajor, 
>> unsigned int devminor)
>> +{
>> +    FsMount *mount;
>> +
>> +    QTAILQ_FOREACH(mount, mounts, next) {
>> +        if (mount->devmajor == devmajor && mount->devminor == 
>> devminor) {
>> +            return true;
>> +        }
>> +    }
>> +    return false;
>> +}
>> +
>>   static bool build_fs_mount_list_from_mtab(FsMountList *mounts, 
>> Error **errp)
>>   {
>>       struct mntent *ment;
>> @@ -89,6 +105,10 @@ static bool 
>> build_fs_mount_list_from_mtab(FsMountList *mounts, Error **errp)
>>               /* Skip bind mounts */
>>               continue;
>>           }
>> +        if (dev_exists(mounts, devmajor, devminor)) {
>> +            /* Skip already existing devices (bind mounts) */
>> +            continue;
>> +        }
>>             mount = g_new0(FsMount, 1);
>>           mount->dirname = g_strdup(ment->mnt_dir);
>> @@ -172,6 +192,11 @@ bool build_fs_mount_list(FsMountList *mounts, 
>> Error **errp)
>>               }
>>           }
>>   +        if (dev_exists(mounts, devmajor, devminor)) {
>> +            /* Skip already existing devices (bind mounts) */
>> +            continue;
>> +        }
>> +
>>           mount = g_new0(FsMount, 1);
>>           mount->dirname = g_strdup(line + dir_s);
>>           mount->devtype = g_strdup(dash + type_s);
>
>
> Ping + add kkostiuk@redhat.com as I missed him in the initial mail.
>

Any chance on a review or getting it merged?
Think it's a good (of course ;)) improvement.


