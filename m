Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8236DC3DA4B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 12:37:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU3uH-000198-12; Wed, 17 Jul 2024 08:37:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sU3u5-00011Y-SB
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 08:37:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sU3u4-0006h5-55
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 08:37:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721219822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dMbhF+jbyuxvxm21urMm6aYMN7+NDlaNDui2LAWrPuo=;
 b=E2rfxIIxPfXImKJt76oTof7PjZ2lh/TvH5M8SwHnuPDku4Ky7TycL7Mg8xLzynM0e4hIUe
 exPSVBbWyoGLsrk7kLanysGxKLdu/OV0/whBx05nJHY/PofVbXRiw6iO+Kx5k1v3cEuTBu
 4ZBiyPx8sLkliCPBNTVIb1avnISMgaU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-j31NpKH0Pvaj0iGVvGiAFw-1; Wed, 17 Jul 2024 08:37:00 -0400
X-MC-Unique: j31NpKH0Pvaj0iGVvGiAFw-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7a1419b065cso811758985a.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 05:37:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721219820; x=1721824620;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dMbhF+jbyuxvxm21urMm6aYMN7+NDlaNDui2LAWrPuo=;
 b=e0uqEueNfF6yglShChMbFlrtVXLh8KwkMp03eZeTrEHzAnpz+f5rfKd0o7TG4+xHDW
 ab4nEPzE4cPoR+8BOk+BongNBXlmPOvv4TZ4m7WQgfKTvfuzwCksq5dzKOGPJCOgsDGn
 dP300hHmNZPpFZk1zKRYz21j+KwGKyahVIUPl5cZCj99HeIJWsGaaW7w/65FO43ycX+t
 9rZ2AAh7gf+Glahsosxu8KHu1myDrmukIUwiOFqhoat/LttH8GXK1zL8SBAXUntnU7ga
 whE9mg9YxoOrydmSphcrwWvtYKfWpvFz209Aa8Ef57XsDUrt4kg7DoKdxUwX7W1nbw9I
 bOAQ==
X-Gm-Message-State: AOJu0YwEYyOokoBU/MfJp+FBF7XVzb768Cj/fchx8Cn5xL4vAL1oKHMd
 lhLdRnr7l77fWVLi3rLoP+bppca74bHNyja8eKwDGrAWyPfjh0Kdf1hcoBM3abz1L2h1uGeXjrH
 dYmaRfqNsBP5pbT35TOnj/NgdRQUSPm4AEVS/2j9sVCB0tIIlpf8pxOB2HrPN
X-Received: by 2002:a05:620a:4451:b0:79c:4030:d891 with SMTP id
 af79cd13be357-7a1874133f4mr165580185a.12.1721219819980; 
 Wed, 17 Jul 2024 05:36:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjwUTzurxGzX0cSqqdc7BJXvQRqV2wRTs7Dzu8LmcfsKgcmo2553d5N+xQ5n8rqZreZIPiGg==
X-Received: by 2002:a05:620a:4451:b0:79c:4030:d891 with SMTP id
 af79cd13be357-7a1874133f4mr165577685a.12.1721219819567; 
 Wed, 17 Jul 2024 05:36:59 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-153.retail.telecomitalia.it.
 [82.57.51.153]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a160ba7e89sm399415685a.23.2024.07.17.05.36.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jul 2024 05:36:59 -0700 (PDT)
Date: Wed, 17 Jul 2024 14:36:54 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com
Subject: Re: [PATCH] scripts/checkpatch: emit a warning if an imported file
 is touched
Message-ID: <ni42nvzvd4zyomuai6q4a32wejlyr3naneuviyx7qem6c2ijhj@tmj2aiqiokcm>
References: <20240717093752.50595-1-sgarzare@redhat.com>
 <87o76w9w6h.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87o76w9w6h.fsf@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jul 17, 2024 at 11:58:46AM GMT, Cornelia Huck wrote:
>On Wed, Jul 17 2024, Stefano Garzarella <sgarzare@redhat.com> wrote:
>
>> If a file imported from Linux is touched, emit a warning and suggest
>> using scripts/update-linux-headers.sh
>>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>>  scripts/checkpatch.pl | 14 ++++++++++++--
>>  1 file changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>> index ff373a7083..b0e8266fa2 100755
>> --- a/scripts/checkpatch.pl
>> +++ b/scripts/checkpatch.pl
>> @@ -1374,6 +1374,7 @@ sub process {
>>  	my $in_header_lines = $file ? 0 : 1;
>>  	my $in_commit_log = 0;		#Scanning lines before patch
>>  	my $reported_maintainer_file = 0;
>> +	my $reported_imported_file = 0;
>>  	my $non_utf8_charset = 0;
>>
>>  	our @report = ();
>> @@ -1673,8 +1674,17 @@ sub process {
>>  # ignore non-hunk lines and lines being removed
>>  		next if (!$hunk_line || $line =~ /^-/);
>>
>> -# ignore files that are being periodically imported from Linux
>> -		next if ($realfile =~ /^(linux-headers|include\/standard-headers)\//);
>> +# ignore files that are being periodically imported from Linux and emit a warning
>> +		if ($realfile =~ /^(linux-headers|include\/standard-headers)\//) {
>> +			if (!$reported_imported_file) {
>> +				$reported_imported_file = 1;
>> +				WARN("added, moved or deleted file(s) " .
>> +				     "imported from Linux, are you using " .
>> +				     "scripts/update-linux-headers.sh?\n" .
>> +				     $herecurr);
>> +			}
>> +			next;
>> +		}
>
>Thanks, that looks useful -- just two comments (sorry, my perl-fu is
>low):

Same perl-fu here ;-P

>- Is there a way to check that this is a proper linux headers update?
>  We'd have to rely on heuristics, but OTOH, we also usually want a
>  headers update to use a certain format ($SUBJECT containing "headers
>  update", patch description pointing to the version this update was
>  done against.) Not sure if it is worth actually trying to figure this
>  out.

I think it can be done though I think we should formalize it somewhere 
first, or integrate the generation of the commit in the 
scripts/update-linux-headers.sh

At that point here we can add a check based on that.

>- A common issue is headers changes mixed in with other code changes,
>  which should not happen -- can we check for that as well and advise
>  to either do a headers update, or use a placeholder patch?

Yeah, Daniel suggested the same, I'll address in v2.

Thanks,
Stefano


